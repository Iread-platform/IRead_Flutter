import 'package:iread_flutter/bloc/base/base_bloc.dart';

class StoryEvent extends BlocEvent {}

class LoadingEvent extends StoryEvent {}

class SearchByTagEvent extends StoryEvent {
  final String _title;
  SearchByTagEvent(this._title);

  get title => _title;
}
