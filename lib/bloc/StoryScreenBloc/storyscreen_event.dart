part of 'storyscreen_bloc.dart';

@immutable
abstract class StoryscreenEvent {}

class GetAudioEvent extends StoryscreenEvent {}

class GetStoryEvent extends StoryscreenEvent {}

class PlayEvent extends StoryscreenEvent {
  String url;
  PlayEvent(url);
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
