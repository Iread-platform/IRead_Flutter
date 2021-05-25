import 'package:flutter/material.dart';
import 'package:iread_flutter/bloc/story_player_bloc.dart';
import 'package:iread_flutter/views/widgets/media/story_audio_player.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StoryAudioPlayer(
            audioUrl: widget._audioUrl,
            isLocalFile: widget._isAssetFile,
            bloc: Provider.of<StoryAudioPlayerBloc>(context)),
      ],
    );
  }
}
