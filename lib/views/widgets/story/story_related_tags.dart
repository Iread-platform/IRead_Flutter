import 'package:flutter/material.dart';

class StoryRelatedTags extends StatelessWidget {
  final String _relatedTagsHeader = 'Related Tags';

  const StoryRelatedTags({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            _relatedTagsHeader,
            style: Theme.of(context).textTheme.headline4,
          )
        ],
      ),
    );
  }
}
