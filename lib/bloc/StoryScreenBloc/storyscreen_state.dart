part of 'storyscreen_bloc.dart';

abstract class StoryscreenState extends BlocState {}

class LoadedState extends SuccessState<Data> {
  LoadedState({data}) : super(data: data);
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

class HighLightWordState extends StoryscreenState {
  int index;
  HighLightWordState({this.index});
}

class HighLightSentenceState extends StoryscreenState {
  List<TextSpan> spans;
  HighLightSentenceState(this.spans);
}
