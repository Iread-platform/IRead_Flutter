part of 'storyscreen_bloc.dart';

@immutable
abstract class StoryscreenState {}

class StoryscreenInitial extends StoryscreenState {}

class LoadingState extends StoryscreenState {}

class LoadedState extends StoryscreenState {
  Data<StoryPage> data;
  LoadedState({this.data});
}

class PlayerState extends StoryscreenState {
  AudioPlayerState audioState = AudioPlayerState.PLAYING;
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
  ErrorState({this.message});
}

class HighLightWordState extends StoryscreenState {
  int index;
  HighLightWordState({this.index});
}

class HighLightSentenceState extends StoryscreenState {
  List<TextSpan> spans;
  HighLightSentenceState(this.spans);
}
