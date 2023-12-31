import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/models/draw/polygon.dart';
import 'package:iread_flutter/utils/data.dart';

class NoPolygonState extends SuccessState {}

class PolygonDeletedState extends NoPolygonState {
  Polygon polygon;
}

class PolygonState extends SuccessState<Data> {
  PolygonState({Data data}) : super(data: data);
}

class DrawPolygonState extends PolygonState {}

class PolygonRecordSaved extends PolygonState {}

class PolygonSavingStreamState extends PolygonState {
  Stream stream;
  PolygonSavingStreamState(this.stream);
}

class PolygonSavingState extends PolygonState {}

class PolygonSavedState extends PolygonState {
  PolygonSavedState(Data success) : super(data: success);
}

class PolygonDeletingState extends PolygonState {}

class PolygonFailState extends PolygonState {}
