import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/shared/progress_bar.dart';
import 'package:rxdart/rxdart.dart';

class StoryAudioPlayer extends StatefulWidget {
  final _audioUrl;
  final _isAssetFile;

  final BehaviorSubject<int> _progress = new BehaviorSubject();
  final BehaviorSubject<dynamic> _pressPosition = new BehaviorSubject();

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

  bool _dragStarted = false;
  double _lastOffsetX;
  int _lastPosition;

  @override
  void initState() {
    super.initState();

    audioPlayer.onAudioPositionChanged.listen((event) {
      widget._progress.sink.add(event.inMilliseconds);
      widget._pressPosition.sink.add(event.inMilliseconds);
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
        stream: widget._pressPosition.stream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (_duration == null || !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  _progressBar(context, snapshot.data),
                  _progressBarIndicator(context, snapshot),
                ],
              ),
              _controlButtons(context)
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

  Container _progressBar(BuildContext context, dynamic data) {
    // Get progress bar width
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _progressBarWidth = _progressBarKey.currentContext.size.width;
    });

    int progressPercent;
    if (data is int) {
      if (_dragStarted) {
        progressPercent = _lastPosition;
      } else {
        progressPercent = data;
      }
    } else {
      progressPercent = data.inMilliseconds;
    }

    _lastPosition = progressPercent;
    return Container(
      child: GestureDetector(
        key: _progressBarKey,
        child: ProgressBar(
          progress: progressPercent / _duration,
          height: 15.0,
          padding: 2.0,
        ),
        onTapDown: (details) {
          final offsetX = details.localPosition.dx;
          final duration = _calcDuration(offsetX);
          audioPlayer.seek(duration);
          widget._pressPosition.sink.add(_ProgressIndicator(duration, offsetX));
        },
        onHorizontalDragStart: (details) {
          _dragStarted = true;
          final offsetX = details.localPosition.dx;
          _updatePressPosition(offsetX);
        },
        onHorizontalDragUpdate: (details) {
          final offsetX = details.localPosition.dx;
          _updatePressPosition(offsetX);
        },
        onHorizontalDragEnd: (details) {
          _dragStarted = false;
          audioPlayer.seek(_calcDuration(_lastOffsetX));
          audioPlayer.resume();
        },
      ),
    );
  }

  Widget _progressBarIndicator(BuildContext context, dynamic snapshot) {
    if (!snapshot.hasData || _progressBarWidth == null) {
      return SizedBox();
    }

    final data = snapshot.data;

    return Positioned(
      left: _calcProgressIndicatorOffset(data) - 16,
      child: SizedBox(
        width: 20,
        height: 20,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _controlButtons(BuildContext context) => StreamBuilder(
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
      );
  // Calc duration based on indicator position
  Duration _calcDuration(double offsetX) {
    double clickRelativeX = offsetX / _progressBarWidth;

    double milliseconds = clickRelativeX * _duration;

    final duration = Duration(milliseconds: milliseconds.round());

    return duration;
  }

  void _updatePressPosition(double offsetX) {
    widget._pressPosition.sink
        .add(_ProgressIndicator(_calcDuration(offsetX), offsetX));
  }

  // Calc offset in case if the user drag the indicator or just tap on the progress bar
  double _calcProgressIndicatorOffset(dynamic data) {
    double offsetX = 0.0;

    if (data is int) {
      if (_dragStarted) {
        offsetX = _lastOffsetX;
      } else {
        offsetX = data.toDouble();
        offsetX /= _duration;
        offsetX *= _progressBarWidth;
      }
    } else {
      offsetX = data.offsetX;
    }

    offsetX = offsetX < 0
        ? 16
        : offsetX > _progressBarWidth
            ? _progressBarWidth
            : offsetX;

    _lastOffsetX = offsetX;
    return offsetX;
  }

  get positionStream => audioPlayer.onAudioPositionChanged;

  get durationStream => audioPlayer.onDurationChanged;
}

class _ProgressIndicator {
  int _inMilliseconds;
  int _hours;
  int _minutes;
  int _seconds;
  double _offsetX;

  _ProgressIndicator(Duration duration, double offsetX) {
    _inMilliseconds = duration.inMilliseconds;
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
  get inMilliseconds => _inMilliseconds;
}
