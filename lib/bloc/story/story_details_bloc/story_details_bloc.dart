import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/story/story_details_bloc/story_details_events.dart';
import 'package:iread_flutter/bloc/story/story_details_bloc/story_details_states.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/repo/story_repo.dart';
import 'package:iread_flutter/utils/data.dart';

class StoryDetailsBloc extends Bloc<BlocEvent, BlocState> {
  final StoryRepo _storyRepo = StoryRepo();
  StoryDetailsBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    yield LoadingState();

    switch (event.runtimeType) {
      case FetchStoryDetailsEvent:
        yield await _fetchStoryDetails((event as FetchStoryDetailsEvent).id);
    }
  }

  Future<BlocState> _fetchStoryDetails(int id) async {
    Data<Story> data = await _storyRepo.fetchStoryById(id);

    return StoryDataFetchedState(data.data);
  }
}
