import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/record_bloc/record_events.dart';
import 'package:iread_flutter/bloc/record_bloc/record_state.dart';
import 'package:iread_flutter/models/attachment/attachment.dart';
import 'package:path_provider/path_provider.dart';

class RecordBloc extends Bloc<BlocEvent, BlocState> {
  final List<String> _records;
  io.Directory _appDirectory;
  Recording _current;
  FlutterAudioRecorder _recorder;
  AudioPlayer _audioPlayer = AudioPlayer();

  RecordBloc(BlocState initialState)
      : _records = [],
        super(initialState) {
    _init();
  }

  void _init() async {
    if (io.Platform.isIOS) {
      _appDirectory = await getApplicationDocumentsDirectory();
    } else {
      _appDirectory = await getExternalStorageDirectory();
    }
  }

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    yield LoadingState();
    switch (event.runtimeType) {
      case RecordEvent:
        String recordName = await _record();
        yield RecordingState(recordName);
        break;
      case StopRecordingEvent:
        yield await _stop();
        break;
      case PlayRecordEvent:
        {
          PlayRecordEvent playRecordEvent = event as PlayRecordEvent;
          playRecord(playRecordEvent.record, playRecordEvent.localPath);
          yield PlayingRecordState(
              playRecordEvent.localPath, playRecordEvent.record);
        }
        break;
      case PauseRecordPlayingEvent:
        yield pauseRecordPlaying();
        break;
      case DeleteRecordEvent:
        yield await _delete((event as DeleteRecordEvent).path);
        break;
      case ResetEvent:
        yield _reset();
        break;
      default:
        yield InitialState();
    }
  }

  Future<String> _record() async {
    Fluttertoast.showToast(msg: "Start recording.");
    final length = _records.length;
    String recordName = _appDirectory.path +
        "/record-" +
        DateTime.now().millisecondsSinceEpoch.toString() +
        "-$length";

    _recorder = FlutterAudioRecorder(recordName);
    await _recorder.initialized;
    await _recorder.start();
    _current = await _recorder.current(channel: 0);

    return recordName;
  }

  Future<StopRecordingState> _stop() async {
    _current = await _recorder.stop();
    String recordPath = _current.path;
    return StopRecordingState(recordPath);
  }

  Future<InitialState> _delete(String path) async {
    if (_recorder != null) {
      _recorder.stop();
    }
    _audioPlayer.stop();

    if (path != null) {
      io.File recordFile = io.File(path);
      await recordFile.delete();
    }

    return InitialState();
  }

  void playRecord(Attachment record, String localPath) async {
    Fluttertoast.showToast(msg: "Playing your record");
    _audioPlayer.play(localPath, isLocal: true);
    _audioPlayer.resume();
    _audioPlayer.onPlayerCompletion.listen((event) {
      this.add(PauseRecordPlayingEvent());
    });
  }

  StopRecordingState pauseRecordPlaying() {
    _audioPlayer.pause();
    return StopRecordingState(_current.path);
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  InitialState _reset() {
    _current = null;
    _recorder = null;
    _audioPlayer.release();
    return InitialState();
  }
}
