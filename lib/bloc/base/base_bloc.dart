import 'package:flutter/cupertino.dart';

abstract class BlocState {
  String message = "Success";

  BlocState({String message}) {
    message = message ?? "Success";
  }
}

class LoadingState extends BlocState {}

class InitialState extends BlocState {}

class SuccessState<T> extends BlocState {
  T data;
}

class FailState extends BlocState {
  FailState({@required String message}) : super(message: message);
}

abstract class BlocEvent {}

class LoadingEvent extends BlocEvent {}

class CloseEvent extends BlocEvent {}
