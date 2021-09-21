import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/main_screen/main_screen_bloc_events.dart';
import 'package:iread_flutter/bloc/main_screen/main_screen_bloc_state.dart';

class MainScreenBloc extends Bloc<BlocEvent, BlocState> {
  MainScreenBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    switch (event.runtimeType) {
      case FetchMainScreenDataEvent:
        yield fetchMainScreenData();
    }
  }

  MainScreenDataFetchedState fetchMainScreenData() {
    return MainScreenDataFetchedState();
  }
}
