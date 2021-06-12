import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class StoryPlayerBloc extends ChangeNotifier {
  AudioPlayer audioPlayer;
  Duration duration;
  Duration progress;
  AudioPlayerState audioPlayerState = AudioPlayerState.PLAYING;
  StoryPlayerBloc() {
    audioPlayer = AudioPlayer();
    initListeners();
  }
  void initListeners() {
    audioPlayer.onDurationChanged.listen((Duration d) {
      duration = d;
      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((event) {
      audioPlayerState = event;
      print(audioPlayerState);
      notifyListeners();
    });
    

    audioPlayer.onAudioPositionChanged.listen((event) {
      progress = event;
      notifyListeners();
    });
  }

  void play(String url) async {
    audioPlayer.play(url);
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
