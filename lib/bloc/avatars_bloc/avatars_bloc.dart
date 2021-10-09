import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/avatars_bloc/avatar_events.dart';
import 'package:iread_flutter/bloc/avatars_bloc/avatars_states.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_bloc.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_events.dart';
import 'package:iread_flutter/models/attachment/attachment.dart';
import 'package:iread_flutter/repo/main_repo.dart';
import 'package:iread_flutter/utils/data.dart';

class AvatarsBloc extends Bloc<BlocEvent, BlocState> {
  final _mainRepo = MainRepo();
  List<Attachment> avatars;
  ProfileBloc _profileBloc;

  AvatarsBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    switch (event.runtimeType) {
      case FetchAvatarDataEvent:
        yield await fetchAvatars();
        break;
      case UpdateUserAvatarEvent:
        yield InitialState();
        yield await updateAvatar((event as UpdateUserAvatarEvent).id,
            isProfile: false);
    }
  }

  Future<BlocState> fetchAvatars() async {
    final data = await _mainRepo.fetchUserAvatars();

    if (data.state == DataState.Success) {
      avatars = data.data;
      return AvatarFetchedState(avatars: data.data);
    } else {
      return FailState(message: data.message);
    }
  }

  Future<BlocState> updateAvatar(int id, {bool isProfile = true}) async {
    final data = await _mainRepo.updateAvatar(id);

    if (data.state == DataState.Success) {
      _profileBloc
          .add(UpdateProfilePhotoEvent(imagePath: avatars[id].downloadUrl));
      return AvatarFetchedState(avatars: avatars);
    } else {
      return FailState(message: data.message);
    }
  }

  void setProfileBloc(ProfileBloc profileBloc) {
    _profileBloc = profileBloc;
  }
}
