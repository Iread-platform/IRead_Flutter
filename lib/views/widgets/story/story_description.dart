import 'package:flutter/material.dart';

class StoryDescription extends StatelessWidget {
  final String _title;
  final String _description;
  final String _author;
  final int _pages;

  final String _authorLabel = 'Written by ';
  final String _pagesLabel = 'Number of pages ';

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
          ),
          Text(
            _description,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              _author == null
                  ? _authorLabel + 'Unknown'
                  : _authorLabel + _author,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          _pages != null
              ? Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _pagesLabel + _pages.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
