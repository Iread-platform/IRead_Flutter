import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:iread_flutter/bloc/login_bloc/login_events.dart';
import 'package:iread_flutter/config/app_config.dart';
import 'package:iread_flutter/config/themes/colors.dart';
import 'package:iread_flutter/utils/colors_utils.dart';
import 'package:iread_flutter/utils/validator.dart';
import 'package:iread_flutter/views/widgets/user/avatar.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:restart_app/restart_app.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  LoginBloc bloc;
  BuildContext signInContext;
  @override
  void initState() {
    BlocProvider.of<LoginBloc>(context,listen: false).add(LoginInit());
    //bloc.add(LoginInit());
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<LoginBloc>(context,listen: true);
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    signInContext = context;

    return SingleChildScrollView(
      child: BlocListener<LoginBloc, BlocState>(
        listener: (context, state){
          if(state is SuccessState)
            {
              print("success");
              Future.delayed(Duration(seconds: 2)).then((value){
                Restart.restartApp();
              });
            }
        },
        child: Column(
          children: [
            // ================= Image Header ==================
            Container(
              height: h * 0.3,
              child: Stack(
                children: [
                  Transform.translate(
                    offset: Offset(0, -h * 0.06),
                    child: Container(
                      child: Container(
                        child: Transform.scale(
                          scale: 1.2,
                          child: SvgPicture.asset(
                            "assets/images/shared/curve_top_left.svg",
                            color: AppColors.IReadOrangeAccent,
                            alignment: Alignment.topLeft,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: UserAvatar(
                        showShadow: true,
                        imageUrl:
                        'https://thumbs.dreamstime.com/b/man-hipster-avatar-cartoon-guy-black-hair-flat-icon-blue-background-user-person-character-vector-illustration-185480506.jpg',
                        radius: 70.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: bloc.errorOpacity,
              duration: Duration(milliseconds: 500),
              child: Container(
                
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.red.shade300,
                  borderRadius: BorderRadius.all(Radius.circular(3))
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info_outline,color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Email or Password is not correct",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            //==================== Text Fileds ===========================
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: bloc.loginFormKey,
                child: Container(
                  height: h * 0.5,
                  width: w * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        child: Text("User Name", style: TextStyle(
                            color: colorScheme.primary, fontSize: 18)),
                        margin: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                      ),
                      TextFormField(
                        controller: userNameController,
                        validator: Validator.validUserName,
                        enabled: !(bloc.state is LoadingState),
                        style: TextStyle(
                            color: colorScheme.primary
                        ),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: colorScheme.primary.withAlpha(120),
                            focusColor: Colors.white,
                            hoverColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: colorScheme.primary.withAlpha(120)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            hintText: "User Name",
                            hintStyle: TextStyle(
                                color: colorScheme.primary
                            )
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Text("Password", style: TextStyle(
                            color: colorScheme.primary, fontSize: 18)),
                        margin: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                      ),
                      TextFormField(
                          controller: passwordController,
                          validator: Validator.validPassword,
                          obscureText: hidePassword,
                          enabled: !(bloc.state is LoadingState),
                          style: TextStyle(
                              color: colorScheme.primary
                          ),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: colorScheme.primary.withAlpha(120),
                              focusColor: Colors.white,
                              hoverColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: colorScheme.primary.withAlpha(
                                        120)),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: colorScheme.primary
                              )
                          )
                      ),
                      SizedBox(height: 50),
                      Container(
                        alignment: Alignment.center,
                        child: ProgressButton.icon(iconedButtons: {
                          ButtonState.idle:
                          IconedButton(
                              text: "Login",
                              icon: Icon(
                                  Icons.login_rounded, color: Colors.white),
                              color: colorScheme.primary),
                          ButtonState.loading:
                          IconedButton(
                              text: "Loading",
                              color: colorScheme.primary),
                          ButtonState.fail:
                          IconedButton(
                              text: "Failed",
                              icon: Icon(Icons.cancel, color: Colors.white),
                              color: Colors.red.shade300),
                          ButtonState.success:
                          IconedButton(
                              text: "Success",
                              icon: Icon(
                                Icons.check_circle, color: Colors.white,),
                              color: Colors.green.shade400)
                        },
                            onPressed: () {
                              bloc.add(DoingLogin(email: userNameController.text, password: passwordController.text));
                            },
                            state: bloc.buttonState
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //====================== Footer ==============================
            Container(
              height: h * 0.2,
              child: Transform.translate(
                offset: Offset(w * 0.3, h * 0.1),
                child: Container(
                  child: Transform.scale(
                    scale: 2.2,
                    child: SvgPicture.asset(
                      "assets/images/shared/curve_bottom_right.svg",
                      color: AppColors.IReadBrownAccent,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //=========================== validation Function =========================

}
