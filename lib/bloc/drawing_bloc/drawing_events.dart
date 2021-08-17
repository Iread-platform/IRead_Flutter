import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/models/attachment/attachment.dart';

abstract class DrawEvents extends BlocEvent {}

// Represents events that require synchronization with the server
abstract class DrawSyncEvents extends DrawEvent {}

class DrawEvent extends DrawEvents {}

class FetchPolygonEvent extends DrawEvents {
  int id;
  FetchPolygonEvent(this.id);
}

class SavePolygonEvent extends DrawSyncEvents {}

class RecordSavedEvent extends DrawEvents {
  Attachment attachment;

  RecordSavedEvent(this.attachment);
}

class PolygonSavedEvent extends DrawEvents {}

class DeletePolygonEvent extends DrawSyncEvents {}

class RecordUpdateEvent extends DrawSyncEvents {
  String path;

  RecordUpdateEvent(this.path);
}

class CommentUpdateEvent extends DrawSyncEvents {
  String comment;

  CommentUpdateEvent(this.comment);
}

class PolygonSyncEvent extends DrawEvents {}

class PolygonRecordDeleteEvent extends DrawSyncEvents {}
