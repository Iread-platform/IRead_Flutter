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

class _AudioPlayerState extends State<StoryAudioPlayer>
    with TickerProviderStateMixin {
  AudioCache audioCach = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();
  int _duration;

  GlobalKey _progressBarKey = GlobalKey();

  AnimationController _playPauseAnimationController;

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

    _playPauseAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _playPauseAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: widget._progress.stream,
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (_duration == null || !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              GestureDetector(
                key: _progressBarKey,
                child: ProgressBar(
                  progress: snapshot.data / _duration,
                  height: 15.0,
                  padding: 2.0,
                ),
                onTapDown: (details) {
                  double width = _progressBarKey.currentContext.size.width;
                  double xOffset = details.localPosition.dx;

                  double clickRelativeX = xOffset / width;

                  double milliseconds = clickRelativeX * _duration;

                  audioPlayer
                      .seek(Duration(milliseconds: milliseconds.round()));
                  print('width $width');
                  print('xOffset $xOffset');
                  print('click relative $clickRelativeX');
                  print('duration $_duration');
                  print('milliseconds $milliseconds');
                },
              ),
              StreamBuilder(
                stream: audioPlayer.onPlayerStateChanged,
                builder: (context, AsyncSnapshot<PlayerState> snapshot) {
                  return Container(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: _playPauseAnimationController,
                            size: 25,
                          ),
                          onPressed: () {
                            switch (audioPlayer.state) {
                              case PlayerState.PLAYING:
                                _playPauseAnimationController.reverse();
                                audioPlayer.pause();
                                break;

                              default:
                                _playPauseAnimationController.forward();
                                audioPlayer.resume();
                                break;
                            }
                          },
                          color: Theme.of(context).colorScheme.primary,
                        )
                      ],
                    ),
                  );
                },
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
