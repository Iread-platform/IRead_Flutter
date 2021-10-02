import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/models/story.dart';

abstract class StoryDetailsState extends BlocState {}

abstract class ReviewState extends SuccessState<Story> {
  ReviewState(Story story) : super(data: story);
  get story => this.data;
}

class StoryDataFetchedState extends SuccessState<Story> {
  StoryDataFetchedState(Story story) : super(data: story);

  get story => this.data;
}

class ReviewIsSubmitting extends ReviewState {
  ReviewIsSubmitting(Story story) : super(story);
}

class ReviewSubmittedState extends ReviewState {
  ReviewSubmittedState(Story story) : super(story);
}
