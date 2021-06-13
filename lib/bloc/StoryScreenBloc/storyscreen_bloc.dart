import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:iread_flutter/Repository/story_repository.dart';
import 'package:iread_flutter/models/Data.dart';
import 'package:meta/meta.dart';

part 'storyscreen_event.dart';
part 'storyscreen_state.dart';

class StoryscreenBloc extends Bloc<StoryscreenEvent, StoryscreenState> {
  String url;
  AudioPlayer audioPlayer;
  Duration duration;
  Duration progress;
  AudioPlayerState audioPlayerState;
  // AudioCache /cache;
  StoryRepository storyRepository;
  StoryscreenBloc() : super(StoryscreenInitial()) {
    audioPlayer = AudioPlayer();
    // cache = AudioCache();
    // cache.clearCache();
    audioPlayerState = AudioPlayerState.PLAYING;
    storyRepository = StoryRepository();
    initListeners();
  }
  @override
  Stream<StoryscreenState> mapEventToState(
    StoryscreenEvent event,
  ) async* {
    if (event is GetAudioEvent) {
      yield LoadingState();
      Data<String> audioData = await storyRepository.getAudioURL();
      await Future.delayed(Duration(seconds: 3));
      play(audioData.data);
      yield PlayerState(AudioPlayerState.PLAYING);
    }
    // ======== GetStoryEvent ==========
    else if (event is GetStoryEvent) {
      Data story = await storyRepository.getStory();
      yield LoadedStoryState(story);
    }
    //==========  player Controller ==============
    else {
      //======== Play ==========
      if (event is PlayEvent) {
        play(event.url);
        audioPlayerState = AudioPlayerState.PLAYING;
        yield PlayerState(AudioPlayerState.PLAYING);
      }
      //======== Pause ==========
      else if (event is PauseEvent) {
        pause();
        audioPlayerState = AudioPlayerState.PAUSED;
        yield PlayerState(AudioPlayerState.PAUSED);
      }
      //======== Stop ==========
      else if (event is StopEvent) {
        stop();
        audioPlayerState = AudioPlayerState.STOPPED;

        yield PlayerState(AudioPlayerState.STOPPED);
      }
      //======== Resume ==========
      else if (event is ResumeEvent) {
        resume();
        audioPlayerState = AudioPlayerState.PLAYING;

        yield PlayerState(AudioPlayerState.PLAYING);
      }
      //======== Seek ==========
      else if (event is SeekEvent) {
        seek(event.duration);
        resume();
        audioPlayerState = AudioPlayerState.PLAYING;

        yield PlayerState(AudioPlayerState.PLAYING);
      }
      //======== Progress ==========
      else if (event is ChangeProgressEvent) {
        yield ProgressState(event.progress);
      }
      //======== Duration ==========
      else if (event is ChangeDurationEvent) {
        yield DurationState(event.duration);
      } else {}
    }
  }

  void initListeners() {
    // ====== listen (Duration - Progress - PlayerState) ======
    StreamSubscription duratoionStream;
    duratoionStream = audioPlayer.onDurationChanged.listen((Duration d) {
      duration = d;
      this.add(ChangeDurationEvent(duration));
      audioPlayer.onDurationChanged.drain();
      duratoionStream.cancel();
    });
    // audioPlayer.onPlayerStateChanged.listen((event) {
    //   audioPlayerState = event;
    // });

    audioPlayer.onAudioPositionChanged.listen((event) {
      progress = event;
      this.add(ChangeProgressEvent(progress));
    });
    audioPlayer.onPlayerCompletion.listen((event) {
      this.add(SeekEvent(Duration(milliseconds: 0)));
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
    await audioPlayer.seek(duration);
  }
}
