import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/main_screen/main_screen_bloc_events.dart';
import 'package:iread_flutter/bloc/main_screen/main_screen_bloc_state.dart';
import 'package:iread_flutter/repo/main_repo.dart';

class MainScreenBloc extends Bloc<BlocEvent, BlocState> {
  final MainRepo _mainRepo = MainRepo();

  MainScreenBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    switch (event.runtimeType) {
      case FetchMainScreenDataEvent:
        yield await fetchMainScreenData();
    }
  }

  Future<MainScreenDataFetchedState> fetchMainScreenData() async {
    await _mainRepo.fetchMainScreenData();
    return MainScreenDataFetchedState();
  }
}
