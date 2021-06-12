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
  Duration duration;
  Duration progress;
  AudioPlayerState audioPlayerState = AudioPlayerState.PLAYING;
  StoryscreenBloc() : super(null) {
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
      play(audioData.data);
      yield LoadedURLState(audioData);
    } else if (event is GetStoryEvent) {
      print("heere");
      Data story = await StoryRepository().getStory();
      yield LoadedStoryState(story);
    } else {
      if (event is PlayEvent) {
        play(event.url);
      } else if (event is PauseEvent) {
        pause();
      } else if (event is StopEvent) {
        stop();
      } else if (event is ResumeEvent) {
        resume();
      } else if (event is SeekEvent) {
        seek(event.duration);
      } else {}
      yield PlayerState(audioPlayer.state);
    }
  }

  void initListeners() {
    audioPlayer.onDurationChanged.listen((Duration d) {
      duration = d;
    });

    audioPlayer.onPlayerStateChanged.listen((event) {
      audioPlayerState = event;
      print(audioPlayerState);
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      progress = event;
    });
  }

  void play(String url) async {
    await audioPlayer.play(url);
  }

  void pause() {
    audioPlayer.pause();
  }

  void resume() {
    audioPlayer.resume();
  }

  void stop() {
    audioPlayer.stop();
  }

  void seek(Duration duration) {
    audioPlayer.seek(duration);
  }
}
