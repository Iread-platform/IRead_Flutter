import 'package:flutter/material.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';
import 'package:iread_flutter/config/themes/shadows.dart';
import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/profile_story_card.dart';

class StoriesList extends StatelessWidget {
  final GlobalKey<AnimatedListState> _listKey;
  final StoriesSectionModel _stories;
  StoriesList(
      {Key key,
      GlobalKey<AnimatedListState> listKey,
      StoriesSectionModel stories})
      : _listKey = listKey ?? GlobalKey(),
        _stories = stories,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _storiesList(context);
  }

  Widget _storiesList(BuildContext context) {
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
                              _stories.title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (index <= _stories.stories.length) {
                    Story story = _stories.stories[index - 1];
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
}
