import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/utils/data.dart';

class DrawSavedState extends SuccessState<Data> {
  DrawSavedState(Data success) : super(data: success);
}
