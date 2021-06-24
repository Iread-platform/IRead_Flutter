import 'package:iread_flutter/bloc/base/base_bloc.dart';

class RecordEvent extends BlocEvent {}

class StopRecordingEvent extends BlocEvent {}

class PlayRecordEvent extends BlocEvent {
  String _recordPath;
  PlayRecordEvent(this._recordPath);

  get recordPath => _recordPath;
}

class PauseRecordPlayingEvent extends BlocEvent {}

class DeleteRecordEvent extends BlocEvent {
  String _path;

  DeleteRecordEvent(this._path);

  get path => _path;
}

class ResetEvent extends BlocEvent {}
