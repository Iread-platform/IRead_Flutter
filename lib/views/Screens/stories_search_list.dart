import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/story_bloc/story_bloc.dart';
import 'package:iread_flutter/bloc/story_bloc/story_state.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';
import 'package:iread_flutter/config/themes/shadows.dart';
import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/profile_story_card.dart';

class StoriesSearchList extends StatefulWidget {
  const StoriesSearchList({Key key}) : super(key: key);

  @override
  _StoriesSearchListState createState() => _StoriesSearchListState();
}

class _StoriesSearchListState extends State<StoriesSearchList> {
  StoryBloc _storyBloc;

  @override
  void initState() {
    super.initState();
    _storyBloc = context.read<StoryBloc>();
    print(_storyBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryBloc, StoryState>(
        bloc: _storyBloc,
        builder: (context, state) {
          print("State type is ${state.runtimeType}");
          switch (state.runtimeType) {
            case SearchByTagState:
              final stories = (state as SearchByTagState).storiesSection;
              return _storiesList(context, stories);
            case StoryLoadingState:
              return Center(child: CircularProgressIndicator());
          }

          return CircularProgressIndicator();
        });
  }

  Row _storiesList(BuildContext context, StoriesSectionModel stories) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                clipBehavior: Clip.none,
                itemBuilder: (context, int index) {
                  if (index == 0) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
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
                    );
                  }

                  Story story = stories.stories[index - 1];
                  return ProfileStoryCard(
                    story: story,
                  );
                },
                separatorBuilder: (context, int index) {
                  return SizedBox(
                    height: 12,
                  );
                },
                itemCount: stories.stories.length + 1))
      ],
    );
  }
}
