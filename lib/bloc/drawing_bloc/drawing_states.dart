import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/utils/data.dart';

class PolygonSavedState extends SuccessState<Data> {
  PolygonSavedState(Data success) : super(data: success);
}
