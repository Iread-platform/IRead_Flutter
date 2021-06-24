import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/record_bloc/record_events.dart';
import 'package:iread_flutter/bloc/record_bloc/record_state.dart';
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
          playRecord(playRecordEvent.recordPath);
          yield PlayingRecordState(playRecordEvent.recordPath);
        }
        break;
      default:
        yield InitialState();
    }
  }

  Future<String> _record() async {
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

  void playRecord(String path) async {
    print("Audio file path is $path");
    _audioPlayer.play(path, isLocal: true);
    _audioPlayer.resume();
  }
}
