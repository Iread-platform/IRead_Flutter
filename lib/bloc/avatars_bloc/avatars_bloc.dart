import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/avatars_bloc/avatar_events.dart';
import 'package:iread_flutter/bloc/avatars_bloc/avatars_states.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/repo/main_repo.dart';
import 'package:iread_flutter/utils/data.dart';

class AvatarsBloc extends Bloc<BlocEvent, BlocState> {
  final _mainRepo = MainRepo();

  AvatarsBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    switch (event.runtimeType) {
      case FetchAvatarDataEvent:
        yield await fetchAvatars();
        break;
      case UpdateUserAvatarEvent:
        yield InitialState();
    }
  }

  Future<BlocState> fetchAvatars() async {
    final data = await _mainRepo.fetchUserAvatars();

    if (data.state == DataState.Success) {
      return AvatarFetchedState(avatars: data.data);
    } else {
      return FailState(message: data.message);
    }
  }

  Future<BlocState> updateAvatar(String url) async {}
}
