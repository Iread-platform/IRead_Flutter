import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/shared/progress_bar.dart';
import 'package:rxdart/rxdart.dart';

class StoryAudioPlayer extends StatefulWidget {
  final _audioUrl;
  final _isLocalFile;

  final _bloc;

  StoryAudioPlayer({audioUrl, isLocalFile, bloc})
      : _audioUrl = audioUrl,
        _isLocalFile = isLocalFile,
        _bloc = bloc;

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<StoryAudioPlayer>
    with TickerProviderStateMixin {
  GlobalKey _progressBarKey = GlobalKey();

  AnimationController _playPauseAnimationController;

  @override
  void initState() {
    super.initState();

    widget._bloc.init(widget._audioUrl, widget._isLocalFile);

    _playPauseAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _playPauseAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: widget._bloc.positionStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (widget._bloc.duration == null || !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          widget._bloc.calcLastPosition(snapshot.data);

          return Column(
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  _progressBar(context, snapshot.data),
                  _progressBarIndicator(context, snapshot),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      child: Container(color: Colors.transparent),
                      onTapDown: (details) {
                        final offsetX = details.localPosition.dx;
                        widget._bloc.playOnOffset(offsetX);
                      },
                      onHorizontalDragStart: (details) {
                        final offsetX = details.localPosition.dx;
                        widget._bloc.startDrag(offsetX);
                      },
                      onHorizontalDragUpdate: (details) {
                        final offsetX = details.localPosition.dx;
                        widget._bloc.updatePressPosition(offsetX);
                      },
                      onHorizontalDragEnd: (details) {
                        widget._bloc.endDrag();
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _positionCounter(
                        context,
                        _ProgressIndicator(
                            Duration(milliseconds: widget._bloc.lastPosition),
                            0)),
                    _positionCounter(
                        context,
                        _ProgressIndicator(
                            Duration(milliseconds: widget._bloc.duration), 0))
                  ],
                ),
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
    widget._bloc.dispose();
    super.dispose();
  }

  Container _progressBar(BuildContext context, dynamic data) {
    // Get progress bar width
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget._bloc._progressBarWidth =
          _progressBarKey.currentContext.size.width;
    });

    return Container(
      key: _progressBarKey,
      child: ProgressBar(
        progress: widget._bloc.progressPercent,
        height: 15.0,
        padding: 2.0,
      ),
    );
  }

  Widget _progressBarIndicator(BuildContext context, dynamic snapshot) {
    if (!snapshot.hasData || widget._bloc.progressBarWidth == null) {
      return SizedBox();
    }

    final data = snapshot.data;

    return Positioned(
      left: widget._bloc.calcProgressIndicatorOffset(data) - 10,
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
        stream: widget._bloc.playerStateStream,
        builder: (context, AsyncSnapshot<AudioPlayerState> snapshot) {
          return Container(
            alignment: Alignment.center,
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  splashRadius: 24,
                  iconSize: 32,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(0),
                  icon: snapshot.data != AudioPlayerState.COMPLETED
                      ? AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          progress: _playPauseAnimationController,
                        )
                      : Icon(Icons.refresh),
                  onPressed: () {
                    switch (widget._bloc.currentState) {
                      case AudioPlayerState.PLAYING:
                        _playPauseAnimationController.reverse();
                        widget._bloc.pause();
                        break;

                      case AudioPlayerState.COMPLETED:
                        _playPauseAnimationController.forward();
                        widget._bloc.stop();
                        break;

                      default:
                        _playPauseAnimationController.forward();
                        widget._bloc.resume();
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

  Text _positionCounter(BuildContext context, _ProgressIndicator progress) =>
      Text(
        '${progress.minutes}:${progress.seconds}',
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Theme.of(context).colorScheme.primary),
      );
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

class StoryAudioPlayerBloc extends ChangeNotifier {
  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();
  int _duration;

  double _progressBarWidth;
  bool _dragStarted = false;
  double _lastOffsetX;
  int _lastPosition;

  final BehaviorSubject<dynamic> _pressPosition = new BehaviorSubject();

  void init(String audioUrl, bool isLocalFile) {
    audioPlayer.onAudioPositionChanged.listen((event) {
      addPosition(event.inMilliseconds);
    });
    audioPlayer.onDurationChanged.listen((event) {
      _duration = event.inMilliseconds;
    });

    audioPlayer.play(audioUrl);
  }

  void addPosition(dynamic position) {
    _pressPosition.sink.add(position);
  }

  void updatePressPosition(double offsetX) {
    offsetX = offsetX < 0
        ? 0
        : offsetX > _progressBarWidth
            ? _progressBarWidth
            : offsetX;
    _pressPosition.sink.add(_ProgressIndicator(calcDuration(offsetX), offsetX));
  }

  // Calc duration based on indicator position
  Duration calcDuration(double offsetX) {
    double clickRelativeX = offsetX / _progressBarWidth;

    double milliseconds = clickRelativeX * _duration;

    final duration = Duration(milliseconds: milliseconds.round());

    return duration;
  }

  // Calc offset in case if the user drag the indicator or just tap on the progress bar
  double calcProgressIndicatorOffset(dynamic data) {
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

    _lastOffsetX = offsetX;
    return offsetX;
  }

  void calcLastPosition(dynamic data) {
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
  }

  void playOnOffset(double offsetX) {
    final duration = calcDuration(offsetX);
    audioPlayer.seek(duration);
    addPosition(_ProgressIndicator(duration, offsetX));
  }

  void startDrag(double offsetX) {
    _dragStarted = true;
    updatePressPosition(offsetX);
  }

  void endDrag() {
    _dragStarted = false;
    audioPlayer.seek(calcDuration(_lastOffsetX));
    audioPlayer.resume();
  }

  void resume() {
    audioPlayer.resume();
  }

  void pause() {
    audioPlayer.pause();
  }

  void stop() {
    audioPlayer.stop();
    resume();
  }

  void dispose() {
    _pressPosition.close();
    super.dispose();
  }

  get positionStream => _pressPosition.stream;
  get playerStateStream => audioPlayer.onPlayerStateChanged;

  get duration => _duration;
  get dragStarted => _dragStarted;
  get lastPosition => _lastPosition;
  get progressPercent => _lastPosition / _duration;
  get currentState => audioPlayer.state;
  get progressBarWidth => _progressBarWidth;
}
