import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/story_bloc/story_event.dart';
import 'package:iread_flutter/bloc/story_bloc/story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc(StoryState initialState) : super(initialState);

  @override
  Stream<StoryState> mapEventToState(StoryEvent event) async* {
    switch (event.runtimeType) {
      case LoadingEvent:
        yield StoryLoadingState();
    }
  }
}
