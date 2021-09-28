import 'package:iread_flutter/bloc/base/base_bloc.dart';

class AvatarEvent extends BlocEvent {}

class FetchAvatarDataEvent extends AvatarEvent {}

class UpdateUserAvatarEvent extends AvatarEvent {
  String avatarUrl;
  UpdateUserAvatarEvent(this.avatarUrl);
}
