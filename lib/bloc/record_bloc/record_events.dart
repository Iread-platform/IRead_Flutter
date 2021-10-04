import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/models/attachment/attachment.dart';

class RecordEvent extends BlocEvent {}

class StopRecordingEvent extends BlocEvent {}

class PlayRecordEvent extends BlocEvent {
  Attachment _record;
  String localPath;
  PlayRecordEvent(this._record, this.localPath);

  Attachment get record => _record;
}

class PauseRecordPlayingEvent extends BlocEvent {}

class DeleteRecordEvent extends BlocEvent {
  String _path;

  DeleteRecordEvent(this._path);

  get path => _path;
}

class ResetEvent extends BlocEvent {}
