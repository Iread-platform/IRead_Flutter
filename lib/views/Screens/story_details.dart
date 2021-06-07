import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/story_description.dart';
import 'package:iread_flutter/views/widgets/story/story_details_actions.dart';

class StoryDetails extends StatelessWidget {
  final Story _story;

  StoryDetails({@required Story story, Key key})
      : _story = story,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 50),
      child: ListView(
        children: [
          StoryDetailsActions(
            story: _story,
          ),
          SizedBox(
            height: 24,
          ),
          StoryDescription(
            title: _story.title,
            description: _story.description,
            author: _story.author,
            pages: _story.pages,
          ),
          SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}
