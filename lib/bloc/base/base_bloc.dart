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

  SuccessState({this.data});
}

class FailState extends BlocState {
  FailState({@required String message}) : super(message: message);
}

abstract class BlocEvent {}

class FailEvent extends BlocEvent {
  String message;
  FailEvent({String message}) : this.message = message;
}

class CloseEvent extends BlocEvent {}
