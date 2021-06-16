import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/story_bloc/story_event.dart';
import 'package:iread_flutter/bloc/story_bloc/story_state.dart';
import 'package:iread_flutter/repo/story_repo.dart';

class SearchStoriesByTag extends Bloc<BlocEvent, BlocState> {
  final StoryRepo storyRepo = StoryRepo();

  SearchStoriesByTag(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    switch (event.runtimeType) {
      case LoadingEvent:
        yield LoadingState();
        break;
      case SearchByTagEvent:
        yield await _searchStoriesByTag(event);
        break;
    }
  }

  Future<SearchByTagState> _searchStoriesByTag(SearchByTagEvent event) async {
    return SearchByTagState(data: await storyRepo.searchByTag(event.title));
  }
}
