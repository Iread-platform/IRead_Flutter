import 'package:flutter/cupertino.dart';

enum DataState { Loading, Success, Fail, Init, Close }

abstract class BlocState {
  DataState state = DataState.Success;
  String message = "Success";
}

class LoadingState extends BlocState {
  LoadingState() {
    state = DataState.Loading;
  }
}

class InitialState extends BlocState {
  InitialState() {
    state = DataState.Init;
  }
}

class SuccessState<T> extends BlocState {
  T data;
}

class FailState extends BlocState {
  Widget _widget;
  FailState({@required Exception exception, Widget widget}) : _widget = widget;

  get widget => _widget;
}

abstract class BlocEvent {}

class LoadingEvent extends BlocEvent {}

class CloseEvent extends BlocEvent {}
