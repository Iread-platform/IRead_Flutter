import 'package:iread_flutter/models/stories_section_model.dart';

abstract class StoryState {}

class StoryLoadingState extends StoryState {}

class SearchByTagState extends StoryState {
  final StoriesSectionModel sectionModel;
  SearchByTagState(this.sectionModel);
}
