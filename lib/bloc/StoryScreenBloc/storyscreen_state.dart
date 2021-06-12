part of 'storyscreen_bloc.dart';

@immutable
abstract class StoryscreenState {}

class StoryscreenInitial extends StoryscreenState {}

class LoadingState extends StoryscreenState {}

class LoadedURLState extends StoryscreenState {
  var data;
  LoadedURLState(this.data);
}

class LoadedStoryState extends StoryscreenState {
  var data;
  LoadedStoryState(this.data);
}

class PlayerState extends StoryscreenState {
  AudioPlayerState audioState;
  PlayerState(this.audioState);
}

class ProgressState extends StoryscreenState {
  Duration progress;
  ProgressState(this.progress);
}

class DurationState extends StoryscreenState {
  Duration duration;
  DurationState(this.duration);
}

class ErrorState extends StoryscreenState {
  var message;
  ErrorState(this.message);
}
