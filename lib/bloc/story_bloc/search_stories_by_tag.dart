import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/story_bloc/search_stories_by_tag_event.dart';
import 'package:iread_flutter/bloc/story_bloc/search_stories_by_tag_state.dart';
import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/repo/story_repo.dart';

class SearchStoriesByTag extends Bloc<BlocEvent, BlocState> {
  final StoryRepo storyRepo = StoryRepo();
  StoriesSectionModel stories;

  SearchStoriesByTag(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    switch (event.runtimeType) {
      case LoadingEvent:
        yield LoadingState();
        break;
      case SearchStoriesByTagEvent:
        yield await _searchStoriesByTag(event);
        break;
      case CloseEvent:
        yield SearchStoriesByTagState(data: stories);
        break;
    }
  }

  Future<SearchStoriesByTagState> _searchStoriesByTag(
      SearchStoriesByTagEvent event) async {
    this.stories = await storyRepo.searchByTag(event.title);
    return SearchStoriesByTagState(data: this.stories);
  }
}
