import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/main_screen/main_screen_bloc_events.dart';
import 'package:iread_flutter/bloc/main_screen/main_screen_bloc_state.dart';
import 'package:iread_flutter/repo/main_repo.dart';
import 'package:iread_flutter/utils/data.dart';

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

  Future<BlocState> fetchMainScreenData() async {
    final data = await _mainRepo.fetchMainScreenData();

    if (data.state == DataState.Success) {
      return MainScreenDataFetchedState(storiesSections: data.data);
    } else {
      return FailState(message: data.message);
    }
  }
}
