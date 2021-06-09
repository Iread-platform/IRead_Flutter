part of 'storyscreen_bloc.dart';

@immutable
abstract class StoryscreenState {}

class StoryscreenInitial extends StoryscreenState {}

class Loading extends StoryscreenState {}

class Loaded extends StoryscreenState {
  var data;
  Loaded(this.data);
}

class Error extends StoryscreenState {
  var message;
  Error(this.message);
}
