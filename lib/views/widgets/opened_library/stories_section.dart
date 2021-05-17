import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/story_card.dart';

class StoriesSection extends StatelessWidget {
  final List<Story> _stories;
  final String _title;
  final double _titleBottomSpacing;
  final double _storyWidth;
  final double _horizontalSpace;
  final double _verticalSpace;

  StoriesSection(
      {storiesList,
      @required title,
      storyWidth,
      horizontalSpace,
      verticalSpace,
      titleBottomSpacing})
      : _stories = storiesList,
        _title = title,
        _storyWidth = storyWidth ?? 150,
        _horizontalSpace = horizontalSpace ?? 24,
        _verticalSpace = verticalSpace ?? 24,
        _titleBottomSpacing = titleBottomSpacing ?? 32;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _storiesWidgets(context),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _storiesWidgets(BuildContext context) {
    if (_stories == null) {
      return [];
    }

    List<Widget> stories = [];
    _stories.forEach((element) {
      final story = Container(
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
