import 'package:iread_flutter/bloc/base/base_bloc.dart';

abstract class DrawEvents extends BlocEvent {}

class DrawEvent extends DrawEvents {}

class SavePolygonEvent extends DrawEvents {}

class RecordSavedEvent extends DrawEvents {}

class PolygonSavedEvent extends DrawEvents {}

class DeletePolygonEvent extends DrawEvents {}
