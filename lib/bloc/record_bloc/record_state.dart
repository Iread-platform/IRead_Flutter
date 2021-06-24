import 'package:iread_flutter/bloc/base/base_bloc.dart';

class RecordState extends BlocState {
  String _recordPath;

  RecordState(this._recordPath);

  get recordPath => _recordPath;
}

class RecordingState extends RecordState {
  RecordingState(String recordPath) : super(recordPath);
}

class StopRecordingState extends RecordState {
  StopRecordingState(String recordPath) : super(recordPath);
}

class PlayingRecordState extends RecordState {
  PlayingRecordState(String recordPath) : super(recordPath);
}
