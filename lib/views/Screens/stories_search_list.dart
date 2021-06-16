import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/story_bloc/story_bloc.dart';
import 'package:iread_flutter/bloc/story_bloc/story_state.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';
import 'package:iread_flutter/config/themes/shadows.dart';
import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/shared/request_handler.dart';
import 'package:iread_flutter/views/widgets/story/profile_story_card.dart';

class StoriesSearchList extends StatefulWidget {
  const StoriesSearchList({Key key}) : super(key: key);

  @override
  _StoriesSearchListState createState() => _StoriesSearchListState();
}

class _StoriesSearchListState extends State<StoriesSearchList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  SearchStoriesByTag _storyBloc;

  @override
  void initState() {
    super.initState();
    _storyBloc = context.read<SearchStoriesByTag>();
  }

  @override
  Widget build(BuildContext context) {
    return RequestHandler<SearchByTagState, SearchStoriesByTag>(
        main: Container(),
        onSuccess: (context, data) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _init(context, data.data);
          });
          return _storiesList(context, data.data);
        },
        bloc: _storyBloc);
  }

  Widget _storiesList(BuildContext context, StoriesSectionModel stories) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: AnimatedList(
                key: _listKey,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                itemBuilder: (context, int index, animation) {
                  if (index == 0) {
                    return ScaleTransition(
                      scale: animation.drive(Tween<double>(begin: 0, end: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 24),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius:
                                    BorderRadius.circular(storyBorderRadius),
                                boxShadow: [mediumBottomRightShadow]),
                            child: Text(
                              stories.title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (index <= stories.stories.length) {
                    Story story = stories.stories[index - 1];
                    return SlideTransition(
                      position: animation.drive(Tween<Offset>(
                          begin: const Offset(-1, 0), end: const Offset(0, 0))),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ProfileStoryCard(
                          story: story,
                        ),
                      ),
                    );
                  }

                  return Container();
                },
                initialItemCount: 0))
      ],
    );
  }

  void _init(BuildContext context, StoriesSectionModel stories) {
    AnimatedListState state = _listKey.currentState;

    state.insertItem(0, duration: Duration(milliseconds: 300));

    for (int i = 0; i < stories.stories.length; i++) {
      state.insertItem(i, duration: Duration(milliseconds: 400 + i * 100));
    }
  }
}
