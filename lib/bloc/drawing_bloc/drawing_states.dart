import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/utils/data.dart';

class PolygonState extends SuccessState<Data> {
  PolygonState({Data data}) : super(data: data);
}

class PolygonRecordSaved extends PolygonState {}

class PolygonSavingState extends PolygonState {}

class PolygonSavedState extends PolygonState {
  PolygonSavedState(Data success) : super(data: success);
}
