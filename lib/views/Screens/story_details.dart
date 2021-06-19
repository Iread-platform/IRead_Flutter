import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/story_description.dart';
import 'package:iread_flutter/views/widgets/story/story_details_actions.dart';
import 'package:iread_flutter/views/widgets/story/story_evaluation.dart';
import 'package:iread_flutter/views/widgets/story/story_related_tags.dart';

class StoryDetails extends StatelessWidget {
  final Story _story;
  final double _verticalSpacing;

  StoryDetails({@required Story story, double verticalSpacing, Key key})
      : _story = story,
        _verticalSpacing = verticalSpacing ?? 48,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 50),
        children: [
          StoryDetailsActions(
            story: _story,
          ),
          SizedBox(
            height: _verticalSpacing,
          ),
          StoryDescription(
            title: _story.title,
            description: _story.description,
            author: _story.author,
            pages: _story.pages,
          ),
          SizedBox(
            height: _verticalSpacing,
          ),
          StoryRelatedTags(
            tags: _story.tags,
          ),
          SizedBox(
            height: _verticalSpacing,
          ),
          StoryEvaluation(),
          SizedBox(
            height: _verticalSpacing,
          )
        ],
      ),
    );
  }
}
