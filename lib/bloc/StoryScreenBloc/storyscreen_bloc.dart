import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/Repository/story_repository.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:iread_flutter/models/Data.dart';
import 'package:iread_flutter/models/story_page_model.dart';
import 'package:provider/provider.dart';

part 'storyscreen_event.dart';
part 'storyscreen_state.dart';

class StoryscreenBloc extends Bloc<BlocEvent, BlocState> {
  String url;
  AudioPlayer audioPlayer;
  Duration duration;
  Duration progress;
  int wordProgressIndex = 0;
  AudioPlayerState audioPlayerState;
  Data<StoryPage> storyPageData;
  var context;
  StoryRepository storyRepository;
  StoryscreenBloc() : super(InitialState()) {
    audioPlayer = AudioPlayer();
    audioPlayerState = AudioPlayerState.PLAYING;
    storyRepository = StoryRepository();
    initListeners();
  }
  @override
  Stream<BlocState> mapEventToState(
    BlocEvent event,
  ) async* {
    // ======== GetStoryEvent ==========
    if (event is FetchStoryPage) {
      yield LoadingState();
      storyPageData = await storyRepository.fetchStoryPage();
      await Future.delayed(Duration(seconds: 1));
      var words = storyPageData.data.words;
      Size size = Size(0, 0);
      double scrollValue = 0;
      String currentString = "";
      words[0].newLine = true;
      words[0].scrollHight = 0;
      for (int i = 0; i < words.length; i++) {
        currentString = currentString + words[i].word + " ";
        size = calcTextSize(currentString, TextStyle(fontSize: 20));

        if (size.width >= (391 * 0.7)) {
          words[i - 1].newLine = true;
          scrollValue = scrollValue + size.height.toInt();
          words[i - 1].scrollHight = scrollValue;
          size = Size(0, 0);
          currentString = " ";
        }
      }
      storyPageData.data.words = words;
      for (Words word in storyPageData.data.words) {
        print(
            "word : ${word.word} , time : ${word.time} , newline : ${word.newLine} , hight : ${word.scrollHight}");
      }
      yield LoadedState(data: storyPageData);
      play(storyPageData.data.audioURL);
      yield PlayerState(AudioPlayerState.PLAYING);
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
      //======== Seek to word ==========

      else if (event is SeekToWordEvent) {
        for (int i = 0; i < storyPageData.data.words.length; i++) {
          if (storyPageData.data.words[i].startIndex >= event.index) {
            seek(Duration(
                milliseconds: storyPageData
                    .data.words[i - 1 >= 0 ? i - 1 : i].time
                    .toInt()));
            resume();
            audioPlayerState = AudioPlayerState.PLAYING;
            yield PlayerState(AudioPlayerState.PLAYING);
            break;
          }
        }
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
          int x = i - 1;
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

  Size calcTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout();
    return textPainter.size;
  }
}
