import 'package:flutter/material.dart';
import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/stories_list.dart';
import 'package:iread_flutter/views/widgets/story/story_card.dart';

class StoriesSection extends StatelessWidget {
  final List<Story> _stories;
  final String _title;
  final double _titleBottomSpacing;
  final double _storyWidth;
  final double _sectionHeight;
  final double _horizontalPadding;
  final int _showFirst;

  StoriesSection(
      {storiesList,
      @required title,
      double storyWidth,
      double titleBottomSpacing,
      double sectionHeight,
      int showFirst,
      double horizontalPadding})
      : _stories = storiesList,
        _title = title,
        _storyWidth = storyWidth ?? 150,
        _titleBottomSpacing = titleBottomSpacing ?? 20,
        _sectionHeight = sectionHeight ?? 250,
        _horizontalPadding = horizontalPadding ?? 12,
        _showFirst = showFirst;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
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
          child: _stories.length > 0
              ? ListView(
                  padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: _storiesWidgets(context),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                  child: Text(
                    "There are no stories",
                    style: Theme.of(context).textTheme.subtitle2,
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
    final storiesToShow = _showFirst != null && _showFirst < _stories.length
        ? _showFirst
        : stories.length;
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
            id: element.id),
      );

      stories.add(story);
    }

    if (_showFirst != null && _stories.length > _showFirst) {
      stories.add(Container(
        margin: const EdgeInsets.only(left: 12, bottom: 80),
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(50)),
          height: 40,
          width: 40,
          child: IconButton(
              tooltip: "Show more",
              color: Theme.of(context).colorScheme.surface,
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: StoriesList(
                      stories: new StoriesSectionModel(_title, _stories),
                      initialCount: _stories.length,
                    ),
                  );
                }));
              }),
        ),
      ));
    }

    return stories;
  }
}
