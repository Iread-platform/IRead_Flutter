part of 'storyscreen_bloc.dart';

@immutable
abstract class StoryscreenEvent {}

class getAudio extends StoryscreenEvent {}

class getStory extends StoryscreenEvent {}
