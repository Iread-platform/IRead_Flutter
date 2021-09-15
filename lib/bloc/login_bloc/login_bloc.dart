import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/login_bloc/login_events.dart';
import 'package:iread_flutter/repo/user_repo.dart';
import 'package:iread_flutter/utils/data.dart';
import 'package:progress_state_button/progress_button.dart';

class LoginBloc extends Bloc<BlocEvent, BlocState> {
  LoginBloc(BlocState initialState) : super(initialState);

  ButtonState buttonState = ButtonState.idle;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  double errorOpacity;

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is LoginInit) {
      buttonState = ButtonState.idle;
      errorOpacity = 0;
      yield InitialState();
    }
    if (event is DoingLogin) {
      var formData = loginFormKey.currentState;
      if (formData.validate()) {
        buttonState = ButtonState.loading;
        errorOpacity = 0;
        yield LoadingState();

        try {
          Data<bool> result =
              await UserRepo().login(event.email, event.password);
          buttonState = ButtonState.success;
          yield SuccessState();
        } catch (e) {
          buttonState = ButtonState.fail;
          errorOpacity = 1;
          print(e);
          yield FailState(message: "Email or Password is not correct");
        }
      }
    }
  }
}
