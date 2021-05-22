import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class StoryPlayer extends StatefulWidget {
  final _audioUrl;
  final _isAssetFile;

  StoryPlayer(audioUrl, isAssetFile)
      : _audioUrl = audioUrl,
        _isAssetFile = isAssetFile;

  @override
  _StoryPlayerState createState() => _StoryPlayerState();
}

class _StoryPlayerState extends State<StoryPlayer> {
  AudioCache audioCach = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    audioPlayer.play(widget._audioUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
