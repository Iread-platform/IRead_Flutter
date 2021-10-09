import 'package:iread_flutter/bloc/base/base_bloc.dart';

class ProfileEvents extends BlocEvent {}

class FetchUserProfileEvent extends ProfileEvents {}

class UpdateProfilePhotoEvent extends ProfileEvents {
  String imagePath;

  UpdateProfilePhotoEvent({this.imagePath});
}
