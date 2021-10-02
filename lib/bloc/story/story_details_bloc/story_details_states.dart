import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/models/story.dart';

abstract class StoryDetailsState extends BlocState {}

abstract class ReviewState extends BlocState {}

class StoryDataFetchedState extends SuccessState<Story> {
  StoryDataFetchedState(Story story) : super(data: story);

  get story => this.data;
}

class ReviewSubmittedState extends ReviewState {}
