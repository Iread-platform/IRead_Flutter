import 'package:iread_flutter/bloc/base/base_bloc.dart';

abstract class StoryDetailsEvent extends BlocEvent {}

class FetchStoryDetailsEvent extends StoryDetailsEvent {
  final int _id;
  FetchStoryDetailsEvent(this._id);

  get id => _id;
}
