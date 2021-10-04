import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/models/attachment/attachment.dart';

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
  Attachment record;
  PlayingRecordState(String recordPath, this.record) : super(recordPath);
}
