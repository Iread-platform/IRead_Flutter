import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_events.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_states.dart';
import 'package:iread_flutter/models/user/profile.dart';
import 'package:iread_flutter/repo/main_repo.dart';
import 'package:iread_flutter/utils/data.dart';

class ProfileBloc extends Bloc<BlocEvent, BlocState> {
  final _mainRepo = MainRepo();
  Profile profile;

  ProfileBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    switch (event.runtimeType) {
      case FetchUserProfileEvent:
        yield await fetchUserProfile();
    }
  }

  Future<BlocState> fetchUserProfile() async {
    final data = await _mainRepo.fetchUserProfile();
    if (data.state == DataState.Success) {
      profile = data.data;
      return ProfileDataFetched(profileData: data);
    } else {
      return FailState(message: data.message);
    }
  }

  Future<BlocState> fetchAvatars() async {
    final data = await _mainRepo.fetchUserAvatars();

    if (data.state == DataState.Success) {
      return ProfileAvatarsDataFetchedState(
          avatars: data.data, profile: profile);
    } else {
      return FailState(message: data.message);
    }
  }
}
