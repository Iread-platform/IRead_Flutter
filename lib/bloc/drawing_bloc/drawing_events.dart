import 'package:iread_flutter/bloc/base/base_bloc.dart';

abstract class DrawEvents extends BlocEvent {}

class DrawEvent extends DrawEvents {}

class FetchPolygonEvent extends DrawEvents {
  int id;
  FetchPolygonEvent(this.id);
}

class SavePolygonEvent extends DrawEvents {}

class RecordSavedEvent extends DrawEvents {}

class PolygonSavedEvent extends DrawEvents {}

class DeletePolygonEvent extends DrawEvents {}

class RecordUpdateEvent extends DrawEvents {
  String path;

  RecordUpdateEvent(this.path);
}

class CommentUpdateEvent extends DrawEvents {
  String comment;

  CommentUpdateEvent(this.comment);
}

class PolygonSyncEvent extends DrawEvents {}

class PolygonRecordDeleteEvent extends DrawEvents {}
