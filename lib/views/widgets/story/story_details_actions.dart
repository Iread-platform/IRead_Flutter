import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/story_image.dart';

class StoryDetailsActions extends StatelessWidget {
  final Story _story;

  const StoryDetailsActions({@required Story story, Key key})
      : _story = story,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              width: 200,
              child: StoryImage(imageUrl: _story.imageUrl, color: _story.color))
        ],
      ),
    );
  }
}
