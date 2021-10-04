import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/models/attachment/attachment.dart';

class AvatarState extends BlocState {}

class AvatarFetchedState extends SuccessState {
  AvatarFetchedState({List<Attachment> avatars}) : super(data: avatars);
}

class AvatarUpdatedState extends SuccessState {}
