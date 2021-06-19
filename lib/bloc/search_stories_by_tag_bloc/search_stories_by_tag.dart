import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/search_stories_by_tag_bloc/search_stories_by_tag_event.dart';
import 'package:iread_flutter/bloc/search_stories_by_tag_bloc/search_stories_by_tag_state.dart';
import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/repo/story_repo.dart';
import 'package:iread_flutter/utils/data.dart';

class SearchStoriesByTagBloc extends Bloc<BlocEvent, BlocState> {
  final StoryRepo storyRepo = StoryRepo();
  StoriesSectionModel stories;

  SearchStoriesByTagBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    switch (event.runtimeType) {
      case SearchStoriesByTagEvent:
        yield await _searchStoriesByTag(event);
        break;
      case CloseEvent:
        yield SearchStoriesByTagState(data: stories);
        break;
    }
  }

  Future<BlocState> _searchStoriesByTag(SearchStoriesByTagEvent event) async {
    final data = await storyRepo.searchByTag(event.title);

    if (data.state == DataState.Success) {
      this.stories = data.data;
      return SearchStoriesByTagState(data: this.stories);
    }

    return FailState(message: data.message);
  }
}
