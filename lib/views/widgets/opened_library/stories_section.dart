import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/story/story_card.dart';

class StoriesSection extends StatelessWidget {
  final List<Story> _stories;
  final String _title;
  final double _titleBottomSpacing;
  final double _storyWidth;
  final double _sectionHeight;
  final double _horizontalPadding;
  final bool _showFirst10;

  StoriesSection(
      {storiesList,
      @required title,
      double storyWidth,
      double titleBottomSpacing,
      double sectionHeight,
      bool showFirst10 = false,
      double horizontalPadding})
      : _stories = storiesList,
        _title = title,
        _storyWidth = storyWidth ?? 150,
        _titleBottomSpacing = titleBottomSpacing ?? 20,
        _sectionHeight = sectionHeight ?? 250,
        _horizontalPadding = horizontalPadding ?? 12,
        _showFirst10 = showFirst10;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: Text(
            _title,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        SizedBox(
          height: _titleBottomSpacing,
        ),
        SizedBox(
          height: _sectionHeight,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: _storiesWidgets(context),
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
    final storiesToShow = _showFirst10 && _stories.length > 10 ? 10 : stories.length;
   for (int i = 0; i < storiesToShow; i++) {
     final element = _stories[i];
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
    }
   
   if (storiesToShow < 10) {
     stories.add(IconButton(icon: Icon(Icons.more), onPressed: onPressed))
   }

    return stories;
  }
}
