abstract class StoryEvent {}

class LoadingEvent extends StoryEvent {}

class SearchByTagEvent extends StoryEvent {
  final String _title;
  SearchByTagEvent(this._title);

  get title => _title;
}
