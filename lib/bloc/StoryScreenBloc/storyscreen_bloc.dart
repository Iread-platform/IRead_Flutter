import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/Repository/story_repository.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/models/story_model.dart';
import 'package:iread_flutter/utils/data.dart';

part 'storyscreen_event.dart';
part 'storyscreen_state.dart';

class StoryscreenBloc extends Bloc<BlocEvent, BlocState> {
  String url;
  AudioPlayer audioPlayer;
  Duration duration, progress;
  double deviceWidth = 0.0, deviceHight = 0.0;
  int wordProgressIndex = 0;
  AudioPlayerState audioPlayerState;
  Data storyPageData;
  StoryRepository storyRepository;
  PageController pageController = PageController();
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
      storyPageData = await storyRepository.fetchStoryPage(event.stotyID);
      try {
        for (var i = 0; i < storyPageData.data.pages.length; i++) {
          // Calculate the last word of each line
          initWordEndLine(storyPageData.data.pages[i].words);
          for (var word in storyPageData.data.pages[i].words) {
            // link highlight interactions with word

            if (word.content.endsWith('.')) {
              word.content = word.content.substring(0, word.content.length - 1);
              word.suffix = '.';
            } else if (word.content.endsWith(',')) {
              word.content = word.content.substring(0, word.content.length - 1);
              word.suffix = ',';
            } else if (word.content.endsWith('?')) {
              word.content = word.content.substring(0, word.content.length - 1);
              word.suffix = ',';
            } else
              word.suffix = '';
            for (var highLight in storyPageData.data.pages[i].highLights) {
              if ((word.startIndex >= highLight.firstWordIndex) &&
                  (word.startIndex <= highLight.endWordIndex)) {
                word.isHighLighted = true;
                word.highLightID = highLight.highLightId;
              }
            }
            // link comment interactions with word
            for (var comment in storyPageData.data.pages[i].comments) {
              if (word.content == comment.word) {
                word.isComment = true;
                word.commentId = comment.commentId;
              }
            }
          }
        }
        yield LoadedState(data: storyPageData);
        play(storyPageData.data.audio.downloadUrl);

        yield PlayerState(AudioPlayerState.PLAYING);
      } catch (e) {}
    }

    // ==========  player Controller ==============
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
        if (event.duration.inMilliseconds <
            storyPageData.data.pages[0].startPageTime) {
          pageController.animateToPage(0,
              duration: Duration(milliseconds: 1000), curve: Curves.linear);
        } else {
          for (int i = 0; i < storyPageData.data.pages.length; i++) {
            if (event.duration.inMilliseconds >=
                    storyPageData.data.pages[i].startPageTime &&
                event.duration.inMilliseconds <=
                    storyPageData.data.pages[i].endPageTime) {
              pageController.animateToPage(i,
                  duration: Duration(milliseconds: 1000), curve: Curves.linear);
              break;
            }
          }
        }

        seek(event.duration);

        resume();
        audioPlayerState = AudioPlayerState.PLAYING;
        yield PlayerState(AudioPlayerState.PLAYING);
      }
      //======== Seek to word ==========

      else if (event is SeekToWordEvent) {
        var words = storyPageData.data.pages[pageController.page.toInt()].words;
        for (int i = 0; i < words.length; i++) {
          if (words[i].startIndex >= event.index) {
            seek(Duration(milliseconds: words[i].timeStart.toInt() + 5));
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
      } else if (event is NextPageEvent) {
        pageController.nextPage(
            duration: Duration(milliseconds: 1000), curve: Curves.linear);
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
    audioPlayer.onPlayerStateChanged.listen((event) {
      audioPlayerState = event;
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      progress = event;
      var words = storyPageData.data.pages[pageController.page.toInt()].words;
      var wordsTemp =
          storyPageData.data.pages[pageController.page.toInt()].words;
      for (int i = 0; i < wordsTemp.length; i++) {
        if (wordsTemp[i].timeStart >= progress.inMilliseconds) {
          int x = i - 1 < 0 ? 0 : i - 1;
          highLightIndex = x.toString();
          if (int.parse(highLightIndex) >= words.length - 1) {
            this.add(NextPageEvent());

            highLightIndex = "0";
          }
          break;
        }
        if (i == words.length - 1) {
          highLightIndex = i.toString();
          this.add(NextPageEvent());
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

  String highLightIndex = "0";
  String storyString;
  List<TextSpan> spans = [];
  List<TextStyle> styles = [];
  List<String> wordsStory;

  Size calcTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout();
    return textPainter.size;
  }

  initWordEndLine(words) {
    // Find the last word in the sentence for scroll
    Size size = Size(0, 0);
    double scrollValue = 0;
    String currentString = "";
    String wordQueue = "";
    words[0].newLine = true;
    words[0].scrollHight = 0.0;
    int startIndex = 0;
    for (int i = 0; i < words.length; i++) {
      //========= calculate start index of word =============

      //=====================================================
      currentString = currentString + words[i].content + " ";
      size = calcTextSize(currentString, TextStyle(fontSize: 40));

      if (size.width >= (deviceWidth * 0.7)) {
        words[i].newLine = true;
        scrollValue = scrollValue + size.height.toInt();
        words[i].scrollHight = scrollValue;
        size = Size(0, 0);
        currentString = " ";
        i--;
      } else {
        words[i].startIndex = startIndex;
        wordQueue = wordQueue + words[i].content + " ";
        startIndex = wordQueue.length;
      }
    }

    return words;
  }
}
