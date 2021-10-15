import 'package:flutter/material.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/story/story_details_bloc/story_details_bloc.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/shared/request_handler.dart';
import 'package:iread_flutter/views/widgets/story/story_description.dart';
import 'package:iread_flutter/views/widgets/story/story_details_actions.dart';
import 'package:iread_flutter/views/widgets/story/story_evaluation.dart';
import 'package:iread_flutter/views/widgets/story/story_related_tags.dart';

class StoryDetails extends StatelessWidget {
  final double _verticalSpacing;

  StoryDetails({Story story, double verticalSpacing, Key key})
      : _verticalSpacing = verticalSpacing ?? 48,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RequestHandler<SuccessState, StoryDetailsBloc>(
      main: Container(
        color: Theme.of(context).colorScheme.surface,
      ),
      onSuccess: (context, state) {
        final story = state.data;
        return Container(
          child: ListView(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 50),
            children: [
              StoryDetailsActions(
                story: story,
              ),
              SizedBox(
                height: _verticalSpacing,
              ),
              StoryDescription(
                title: story.title,
                description: story.description,
                author: story.writer,
                pages: story.pages,
              ),
              SizedBox(
                height: _verticalSpacing,
              ),
              StoryRelatedTags(
                tags: story.tags,
              ),
              SizedBox(
                height: _verticalSpacing,
              ),
              StoryEvaluation(reviews: story.rating.reviews),
              SizedBox(
                height: _verticalSpacing,
              )
            ],
          ),
        );
      },
    );
  }
}
