import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/story_details_actions.dart';

class StoryDetails extends StatelessWidget {
  final Story _story;

  StoryDetails({@required Story story, Key key})
      : _story = story,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 150),
      child: ListView(
        children: [
          StoryDetailsActions(
            story: _story,
          ),
        ],
      ),
    );
  }
}
