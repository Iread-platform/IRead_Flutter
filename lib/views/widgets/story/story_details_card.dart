import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/story_image.dart';

class StoryDetailsCard extends StatelessWidget {
  final Story _story;
  const StoryDetailsCard({Story story, Key key})
      : _story = story,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: 150,
          child: Row(
            children: [
              Expanded(
                  child: StoryImage(
                      imageUrl: _story.imageUrl, color: _story.color))
            ],
          ),
        ),
      ],
    );
  }
}
