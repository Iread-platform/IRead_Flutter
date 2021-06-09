import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:iread_flutter/bloc/Data.dart';
import 'package:meta/meta.dart';

part 'storyscreen_event.dart';
part 'storyscreen_state.dart';

class StoryscreenBloc extends Bloc<StoryscreenEvent, StoryscreenState> {
  StoryscreenBloc() : super(StoryscreenInitial());

  @override
  Stream<StoryscreenState> mapEventToState(
    StoryscreenEvent event,
  ) async* {
    if (event is getAudio) {
      yield Loading();
      // String audioURL = mainre
      // yield Loaded(Data());
    } else if (event is getStory) {}
  }
}
