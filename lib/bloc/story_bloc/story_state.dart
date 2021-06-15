import 'package:iread_flutter/models/stories_section_model.dart';

abstract class StoryState {}

class StoryLoadingState extends StoryState {}

class StoryErrorSate extends StoryState {}

class SearchByTagState extends StoryState {
  final StoriesSectionModel _sectionModel;
  SearchByTagState(this._sectionModel);

  get storiesSection => _sectionModel;
}
