import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/story/story_details_bloc/story_details_events.dart';
import 'package:iread_flutter/bloc/story/story_details_bloc/story_details_states.dart';
import 'package:iread_flutter/models/review/review_submit.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/repo/main_repo.dart';
import 'package:iread_flutter/repo/story_repo.dart';
import 'package:iread_flutter/services/auth_service.dart';
import 'package:iread_flutter/utils/data.dart';

class StoryDetailsBloc extends Bloc<BlocEvent, BlocState> {
  final StoryRepo _storyRepo = StoryRepo();
  Story _story;
  final MainRepo _mainRepo = MainRepo();
  int rate = 0;

  StoryDetailsBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    yield LoadingState();

    switch (event.runtimeType) {
      case FetchStoryDetailsEvent:
        yield await _fetchStoryDetails((event as FetchStoryDetailsEvent).id);
        break;
      case SubmitReviewEvent:
        yield ReviewIsSubmitting(_story);
        yield await _submitReview();
        break;
    }
  }

  Future<BlocState> _fetchStoryDetails(int id) async {
    Data<Story> data = await _storyRepo.fetchStoryById(id);
    _story = data.data;
    return StoryDataFetchedState(_story);
  }

  Future<BlocState> _submitReview() async {
    final ReviewSubmit reviewSubmit =
        new ReviewSubmit(AuthService().cU.id, _story.id, rate);
    final data = await _mainRepo.submitReview(reviewSubmit);

    if (data.state == DataState.Success) {
      return ReviewSubmittedState(_story);
    } else {
      return ReviewErrorState(_story, data.message);
    }
  }
}
