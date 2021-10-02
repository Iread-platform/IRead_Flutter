import 'package:flutter/material.dart';
import 'package:iread_flutter/models/tag.dart' as TagModel;
import 'package:iread_flutter/views/widgets/tag/tag.dart';

class StoryRelatedTags extends StatelessWidget {
  final String _relatedTagsHeader = 'Related Tags';
  final List<TagModel.Tag> _tags;

  const StoryRelatedTags({List<TagModel.Tag> tags, Key key})
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
          SizedBox(
            height: 12,
          ),
          _tags.length > 0
              ? Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  clipBehavior: Clip.antiAlias,
                  children: _buildTags(context),
                )
              : Text(
                  'There are not tags',
                  style: Theme.of(context).textTheme.subtitle2,
                )
        ],
      ),
    );
  }

  List _buildTags(BuildContext context) => _tags
      .map((e) => Tag(
            title: e.title,
          ))
      .toList();
}
