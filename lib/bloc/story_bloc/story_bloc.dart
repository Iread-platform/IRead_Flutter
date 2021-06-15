import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/story_bloc/story_event.dart';
import 'package:iread_flutter/bloc/story_bloc/story_state.dart';
import 'package:iread_flutter/repo/story_repo.dart';

class StoryBloc extends Bloc<BlocEvent, BlocState> {
  final StoryRepo storyRepo = StoryRepo();

  StoryBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
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
        data: await storyRepo.searchByTag(searchByTagEvent.title));
  }
}
