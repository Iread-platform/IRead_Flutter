import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_events.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_states.dart';
import 'package:iread_flutter/models/user/profile.dart';
import 'package:iread_flutter/models/user/user.dart';
import 'package:iread_flutter/repo/main_repo.dart';
import 'package:iread_flutter/services/auth_service.dart';
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
        break;
      case UpdateProfilePhotoEvent:
        yield await _updateProfileImage(
            (event as UpdateProfilePhotoEvent).imagePath);
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

  Future<BlocState> _updateProfileImage(String url) async {
    User user = AuthService().cU..updateImagePath(url);
    AuthService authService = AuthService();

    authService.saveUser(user);
    profile.avatarAttachment?.downloadUrl = url;
    profile.customPhotoAttachment?.downloadUrl = url;

    return ProfileDataFetched(profileData: Data.success(profile));
  }
}
