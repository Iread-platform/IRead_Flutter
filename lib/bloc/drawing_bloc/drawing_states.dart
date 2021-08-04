import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/utils/data.dart';

class PolygonState extends SuccessState<Data> {
  PolygonState({Data data}) : super(data: data);
}

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

class PolygonDeletedState extends PolygonState {
  bool _isDone;

  PolygonDeletedState(bool isDone) : _isDone = isDone;
}
