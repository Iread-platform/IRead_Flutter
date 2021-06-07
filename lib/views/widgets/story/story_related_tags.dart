import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/tag/tag.dart';

class StoryRelatedTags extends StatelessWidget {
  final String _relatedTagsHeader = 'Related Tags';
  final List<String> _tags;

  const StoryRelatedTags({List<String> tags, Key key})
      : _tags = tags,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_tags == null) {
      return Container();
    }

    return Container(
      child: Column(
        children: [
          Text(
            _relatedTagsHeader,
            style: Theme.of(context).textTheme.headline4,
          ),
          Wrap(
            children: _buildTags(context),
          )
        ],
      ),
    );
  }

  List _buildTags(BuildContext context) => _tags
      .map((e) => Tag(
            title: e,
          ))
      .toList();
}
