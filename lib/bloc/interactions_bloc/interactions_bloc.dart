import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:iread_flutter/repo/interaction_repo.dart';
import 'package:meta/meta.dart';

part 'interactions_event.dart';
part 'interactions_state.dart';

class InteractionsBloc extends Bloc<InteractionsEvent, InteractionsState> {
  InteractionsBloc() : super(InteractionsInitial());

  @override
  Stream<InteractionsState> mapEventToState(
    InteractionsEvent event,
  ) async* {
    if (event is HightLightEvent) {
      await InteractionRepo().addHighLightWord(event.map);
    } else if (event is VocabularyEvent) {
    } else {}
  }
}
