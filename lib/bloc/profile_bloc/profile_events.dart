import 'dart:io';

import 'package:iread_flutter/bloc/base/base_bloc.dart';

class ProfileEvents extends BlocEvent {}

class FetchUserProfileEvent extends ProfileEvents {}

class UpdateProfilePhotoEvent extends ProfileEvents {
  File image;
  String imageAssetPath;

  UpdateProfilePhotoEvent({this.image, this.imageAssetPath})
      : assert(image != null || imageAssetPath != null);
}
