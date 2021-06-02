import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/story_card.dart';

class StoriesSection extends StatelessWidget {
  final List<Story> _stories;
  final String _title;
  final double _titleBottomSpacing;
  final double _storyWidth;
  final double _sectionHeight;

  StoriesSection(
      {storiesList,
      @required title,
      storyWidth,
      titleBottomSpacing,
      sectionHeight})
      : _stories = storiesList,
        _title = title,
        _storyWidth = storyWidth ?? 150,
        _titleBottomSpacing = titleBottomSpacing ?? 32,
        _sectionHeight = sectionHeight ?? 150;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _title,
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          height: _titleBottomSpacing,
        ),
        SizedBox(
          height: _sectionHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: _storiesWidgets(context),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _storiesWidgets(BuildContext context) {
    if (_stories == null) {
      return [];
    }

    List<Widget> stories = [];
    _stories.forEach((element) {
      final story = Container(
        margin: EdgeInsets.only(right: 12),
        width: _storyWidth,
        child: StoryCard(
          title: element.title,
          imageUrl: element.imageUrl,
          color: element.color,
          progress: element.progress,
        ),
      );

      stories.add(story);
    });

    return stories;
  }
}
