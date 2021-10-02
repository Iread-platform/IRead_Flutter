import 'package:iread_flutter/bloc/base/base_bloc.dart';

class LoginInit extends BlocEvent {}
class DoingLogin extends BlocEvent {
  String email,password;

  DoingLogin({this.email, this.password});
}