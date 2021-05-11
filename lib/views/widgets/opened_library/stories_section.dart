import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';

class StoriesSection extends StatelessWidget {
  final List<Story> _stories;
  final String _title;

  StoriesSection({storiesList, @required title})
      : _stories = storiesList,
        _title = title;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
