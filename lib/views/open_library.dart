import 'package:flutter/material.dart';
import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/views/widgets/opened_library/stories_section.dart';
import 'package:iread_flutter/views/widgets/story/story_card.dart';

class OpenLibrary extends StatelessWidget {
  final _storyWidth;
  final _verticalSpacing;
  final List<StoriesSectionModel> _sections;

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

    _sections.forEach((e) {
      columnChildren.add(StoriesSection(
        title: e.title,
        storiesList: e.stories,
        storyWidth: _storyWidth,
      ));
      columnChildren.add(SizedBox(
        height: _verticalSpacing,
      ));
    });
    columnChildren.removeLast();

    return columnChildren;
  }
}
