import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';
import 'package:iread_flutter/config/themes/shadows.dart';
import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/profile_story_card.dart';

class StoriesSearchList extends StatelessWidget {
  final StoriesSectionModel _storiesSection;

  const StoriesSearchList(
      {@required StoriesSectionModel storiesSection, Key key})
      : _storiesSection = storiesSection,
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            _storiesSection.title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    );
                  }

                  Story story = _storiesSection.stories[index - 1];
                  return ProfileStoryCard(
                    story: story,
                  );
                },
                separatorBuilder: (context, int index) {
                  return SizedBox(
                    height: 12,
                  );
                },
                itemCount: _storiesSection.stories.length + 1))
      ],
    );
  }
}
