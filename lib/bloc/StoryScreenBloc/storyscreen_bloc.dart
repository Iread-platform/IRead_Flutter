import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/Repository/story_repository.dart';
import 'package:iread_flutter/models/Data.dart';
import 'package:iread_flutter/models/story_page_model.dart';
import 'package:meta/meta.dart';

part 'storyscreen_event.dart';
part 'storyscreen_state.dart';

class StoryscreenBloc extends Bloc<StoryscreenEvent, StoryscreenState> {
  String url;
  AudioPlayer audioPlayer;
  Duration duration;
  Duration progress;
  int wordProgressIndex = 0;
  AudioPlayerState audioPlayerState;
  Data<StoryPage> storyPageData;
  var context;
  StoryRepository storyRepository;
  StoryscreenBloc() : super(StoryscreenInitial()) {
    // storyPageData = Data<StoryPage>(StoryPage(), "");

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
    if (event is FetchStoryPage) {
      yield LoadingState();
      storyPageData = await storyRepository.fetchStoryPage();
      await Future.delayed(Duration(seconds: 1));
      print(storyPageData.data.story);
      yield LoadedState(data: storyPageData);
      play(storyPageData.data.audioURL);
      yield PlayerState(AudioPlayerState.PLAYING);
    }
    // ======== GetStoryEvent ==========

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
      }
      if (event is HighlightWordEvent) {
        // List<TextSpan> s = getStory(highLightword: event.index);

        yield HighLightWordState(index: event.index);
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
      for (int i = 0; i < storyPageData.data.words.length; i++) {
        if (storyPageData.data.words[i].time > progress.inMilliseconds) {
          int x = i-1;
          highLightIndex = x.toString();
          break;
        }
      }
      
      this.add(ChangeProgressEvent(progress));
    });
    audioPlayer.onPlayerCompletion.listen((event) {
      wordProgressIndex = 0;
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

  String highLightIndex;
  String storyString;
  List<TextSpan> spans = [];
  List<TextStyle> styles = [];
  List<String> wordsStory;

  void init(String story) {
    storyString = story;
    wordsStory = storyString.split(" ");
  }

  // List<TextSpan> getStory({int highLightword}) {
  //   spans.clear();
  //   for (int i = 0; i < wordsStory.length; i++) {
  //     styles.add(TextStyle());
  //     spans.add(
  //       TextSpan(
  //         style: highLightword == i
  //             ? TextStyle(backgroundColor: Colors.purple)
  //             : TextStyle(),
  //         text: wordsStory[i] + " ",
  //       ),
  //     );
  //   }
  //   return spans;
  // }
}
