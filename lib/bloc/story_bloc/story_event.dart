abstract class StoryEvent {}

class LoadingEvent extends StoryEvent {}

class SearchByTagEvent extends StoryEvent {
  final String title;
  SearchByTagEvent(this.title);
}
