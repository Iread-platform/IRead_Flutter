import 'package:flutter/material.dart';

class StoryDescription extends StatelessWidget {
  final String _title;
  final String _description;
  final String _author;
  final int _pages;

  const StoryDescription(
      {@required String title,
      @required String description,
      String author,
      int pages,
      Key key})
      : _title = title,
        _description = description,
        _author = author,
        _pages = pages,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            _title,
            style: Theme.of(context).textTheme.headline2,
          )
        ],
      ),
    );
  }
}
