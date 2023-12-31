import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/models/user/user.dart';
import 'package:iread_flutter/utils/data.dart';

class ProfileStates extends BlocState {}

class ProfileDataFetched extends SuccessState {
  ProfileDataFetched({Data profileData}) : super(data: profileData);
}

class UpdateProfileDataSate extends SuccessState {
  UpdateProfileDataSate(Data<User> user) : super(data: user);
}
