import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';

class CommentBloc extends Bloc<BlocEvent, BlocState> {
  CommentBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
