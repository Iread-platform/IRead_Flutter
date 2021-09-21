import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_events.dart';
import 'package:iread_flutter/bloc/profile_bloc/profile_states.dart';
import 'package:iread_flutter/repo/main_repo.dart';

class ProfileBloc extends Bloc<BlocEvent, BlocState> {
  final _mainRepo = MainRepo();

  ProfileBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    switch (event.runtimeType) {
      case FetchUserProfileEvent:
        yield await fetchUserProfile();
    }
  }

  Future<ProfileDataFetched> fetchUserProfile() async {
    final data = await _mainRepo.fetchUserProfile();
    return ProfileDataFetched(profileData: data);
  }
}
