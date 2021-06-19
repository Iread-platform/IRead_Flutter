part of 'storyscreen_bloc.dart';

abstract class StoryscreenEvent {}

class FetchStoryPage extends StoryscreenEvent {}

class PlayEvent extends StoryscreenEvent {
  String url;
  PlayEvent(this.url);
}

class StopEvent extends StoryscreenEvent {}

class PauseEvent extends StoryscreenEvent {}

class ResumeEvent extends StoryscreenEvent {}

class SeekEvent extends StoryscreenEvent {
  Duration duration;
  SeekEvent(this.duration);
}

class ChangeProgressEvent extends StoryscreenEvent {
  Duration progress;
  ChangeProgressEvent(this.progress);
}

class ChangeDurationEvent extends StoryscreenEvent {
  Duration duration;
  ChangeDurationEvent(this.duration);
}

class SeekToWordEvent extends StoryscreenEvent {
  int index;
  SeekToWordEvent({this.index});
}

class HighlightWordEvent extends StoryscreenEvent {
  int index;
  HighlightWordEvent({this.index});
}

class HighlightSentenceEvent extends StoryscreenEvent {
  int index;
  HighlightSentenceEvent({this.index});
}

class VocabularyEvent extends StoryscreenEvent {
  int index;
  VocabularyEvent({this.index});
}
