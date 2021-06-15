import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/story_bloc/story_event.dart';
import 'package:iread_flutter/bloc/story_bloc/story_state.dart';
import 'package:iread_flutter/repo/story_repo.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final StoryRepo storyRepo = StoryRepo();

  StoryBloc(StoryState initialState) : super(initialState);

  @override
  Stream<StoryState> mapEventToState(StoryEvent event) async* {
    switch (event.runtimeType) {
      case LoadingEvent:
        yield StoryLoadingState();
        break;
      case SearchByTagEvent:
        yield await _searchStoriesByTag(event);
        break;
    }
  }

  Future<SearchByTagState> _searchStoriesByTag(StoryEvent event) async {
    SearchByTagEvent searchByTagEvent = event as SearchByTagEvent;

    return SearchByTagState(
        await storyRepo.searchByTag(searchByTagEvent.title));
  }
}
