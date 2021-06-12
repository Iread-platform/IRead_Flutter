import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:iread_flutter/Repository/story_repository.dart';
import 'package:iread_flutter/models/Data.dart';
import 'package:meta/meta.dart';

part 'storyscreen_event.dart';
part 'storyscreen_state.dart';

class StoryscreenBloc extends Bloc<StoryscreenEvent, StoryscreenState> {
  AudioPlayer audioPlayer;
  String url;
  Duration duration;
  Duration progress;
  AudioPlayerState audioPlayerState = AudioPlayerState.PLAYING;
  StoryscreenBloc() : super(StoryscreenInitial()) {
    audioPlayer = AudioPlayer();
    initListeners();
  }
  @override
  Stream<StoryscreenState> mapEventToState(
    StoryscreenEvent event,
  ) async* {
    yield LoadingState();
    if (event is GetAudioEvent) {
      Data<String> audioData = await StoryRepository().getAudioURL();
      yield LoadedURLState(audioData);
      play(audioData.data);
    } else if (event is GetStoryEvent) {
      Data story = await StoryRepository().getStory();
      yield LoadedStoryState(story);
    } else {
      if (event is PlayEvent) {
        play(event.url);
        yield PlayerState(AudioPlayerState.PLAYING);
      } else if (event is PauseEvent) {
        pause();
        yield PlayerState(AudioPlayerState.PAUSED);
      } else if (event is StopEvent) {
        stop();
        yield PlayerState(AudioPlayerState.STOPPED);
      } else if (event is ResumeEvent) {
        resume();
        yield PlayerState(AudioPlayerState.PLAYING);
      } else if (event is SeekEvent) {
        print("event ${event.duration}");
        seek(event.duration);
        resume();
        yield PlayerState(AudioPlayerState.PLAYING);
      } else if (event is ChangeProgressEvent) {
        yield ProgressState(event.progress);
      } else if (event is ChangeDurationEvent) {
        yield DurationState(event.duration);
      } else {}
    }
  }

  void initListeners() {
    StreamSubscription duratoionStream;
    duratoionStream = audioPlayer.onDurationChanged.listen((Duration d) {
      duration = d;
      this.add(ChangeDurationEvent(duration));
      print("ssssss : $d");
      audioPlayer.onDurationChanged.drain();
      duratoionStream.cancel();
    });
    audioPlayer.onPlayerStateChanged.listen((event) {
      audioPlayerState = event;
      print(audioPlayerState);
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      progress = event;

      this.add(ChangeProgressEvent(progress));
    });
  }

  void play(String url) async {
    await audioPlayer.play(url);
  }

  void pause() async {
    await audioPlayer.pause();
  }

  void resume() async {
    await audioPlayer.resume();
  }

  void stop() async {
    await audioPlayer.stop();
  }

  void seek(Duration duration) async {
    print("seeeeeeeeek");
    print(duration);
    await audioPlayer.seek(duration);
  }
}
