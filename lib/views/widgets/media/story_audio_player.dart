import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/shared/progress_bar.dart';
import 'package:rxdart/rxdart.dart';

class StoryAudioPlayer extends StatefulWidget {
  final _audioUrl;
  final _isAssetFile;

  final BehaviorSubject<int> _progress = new BehaviorSubject();
  final BehaviorSubject<_ProgressIndicator> _pressPosition =
      new BehaviorSubject();

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

  double _progressBarWidth;

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
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: GestureDetector(
                      key: _progressBarKey,
                      child: ProgressBar(
                        progress: snapshot.data / _duration,
                        height: 15.0,
                        padding: 2.0,
                      ),
                      onTapDown: (details) {
                        _progressBarWidth =
                            _progressBarKey.currentContext.size.width;
                        double xOffset = details.localPosition.dx;

                        double clickRelativeX = xOffset / _progressBarWidth;

                        double milliseconds = clickRelativeX * _duration;

                        final duration =
                            Duration(milliseconds: milliseconds.round());

                        audioPlayer.seek(duration);

                        widget._pressPosition.sink
                            .add(_ProgressIndicator(duration, xOffset));
                      },
                    ),
                  ),
                  StreamBuilder(
                    stream: widget._pressPosition,
                    builder:
                        (context, AsyncSnapshot<_ProgressIndicator> snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox();
                      }

                      final data = snapshot.data;
                      return Positioned(
                        left: data.offsetX,
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text('${data.minutes} : ${data.seconds}'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
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

  get positionStream => audioPlayer.onAudioPositionChanged;

  get durationStream => audioPlayer.onDurationChanged;
}

class _ProgressIndicator {
  int _hours;
  int _minutes;
  int _seconds;
  double _offsetX;

  _ProgressIndicator(Duration duration, double offsetX) {
    int seconds = duration.inSeconds;

    _hours = (seconds / 3600).floor();
    seconds %= 3600;
    _minutes = (seconds / 60).floor();
    _seconds = seconds % 60;
    _offsetX = offsetX;
  }

  get seconds => _seconds;
  get minutes => _minutes;
  get hours => _hours;
  get offsetX => _offsetX;
}
