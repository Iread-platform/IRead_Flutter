import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/opened_library/stories_section.dart';

class OpenLibrary extends StatelessWidget {
  final _storyWidth;
  final _verticalSpacing;
  final Map<String, List<Story>> _sections;

  OpenLibrary({storyWidth, @required sections, verticalSpacing})
      : _storyWidth = storyWidth ?? 100,
        _sections = sections,
        _verticalSpacing = verticalSpacing ?? 32;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: _sectionsBuilder(context),
        ),
      ),
    );
  }

  List<Widget> _sectionsBuilder(BuildContext context) {
    List<Widget> columnChildren = [];

    _sections.forEach((title, list) {
      StoriesSection storiesSection = StoriesSection(
        title: title,
        storiesList: list,
        storyWidth: _storyWidth,
      );
      columnChildren.add(storiesSection);
    });

    return columnChildren;
  }
}

Story story = Story(
    title: 'Wood, Wire, Wings',
    color: Colors.teal,
    imageUrl: 'https://blog-cdn.reedsy.com/uploads/2019/12/another.jpg',
    progress: 0.45,
    flippedPages: 53,
    readingTime: 127.25);
