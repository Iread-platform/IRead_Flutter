import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/shared/progress_bar.dart';
import 'package:rxdart/rxdart.dart';

class StoryAudioPlayer extends StatefulWidget {
  final _audioUrl;
  final _isAssetFile;

  final BehaviorSubject<int> _progress = new BehaviorSubject();

  StoryAudioPlayer({audioUrl, isAssetFile})
      : _audioUrl = audioUrl,
        _isAssetFile = isAssetFile;

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<StoryAudioPlayer> {
  AudioCache audioCach = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();
  int _duration;

  @override
  void initState() {
    super.initState();
    audioPlayer.onAudioPositionChanged.listen((event) {
      widget._progress.sink.add(event.inMilliseconds);
    });
    audioPlayer.onDurationChanged.listen((event) {
      _duration = event.inMilliseconds;
    });
    audioPlayer.play(widget._audioUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: widget._progress.stream,
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (_duration == null || !snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return Column(
            children: [
              GestureDetector(
                  child: ProgressBar(
                progress: snapshot.data / _duration,
                height: 15.0,
                padding: 2.0,
              )),
              Row(
                children: [
                  IconButton(
                      icon: Icon(audioPlayer.state == PlayerState.PLAYING
                          ? Icons.pause
                          : Icons.play_arrow),
                      onPressed: () {
                        audioPlayer.state == PlayerState.PLAYING
                            ? audioPlayer.pause()
                            : audioPlayer.resume();
                      })
                ],
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget._progress.close();
    super.dispose();
  }
}
