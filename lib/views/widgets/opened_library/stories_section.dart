import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/story_card.dart';

class StoriesSection extends StatelessWidget {
  final List<Story> _stories;
  final String _title;

  StoriesSection({storiesList, @required title})
      : _stories = storiesList,
        _title = title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _title,
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 24,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 24,
            spacing: 24,
            children: _storiesWidgets(context),
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
        width: 150,
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
