import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iread_flutter/views/widgets/user/avatar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
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
                          color: Colors.orangeAccent,
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
                      imageUrl:
                          'https://thumbs.dreamstime.com/b/man-hipster-avatar-cartoon-guy-black-hair-flat-icon-blue-background-user-person-character-vector-illustration-185480506.jpg',
                      radius: 70.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //==================== Text Fileds ===========================
          Form(
            key: loginFormKey,
            child: Container(
              height: h * 0.5,
              width: w * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("User Name"),
                  TextFormField(
                    controller: userNameController,
                    validator: validUserName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: " User Name ",
                    ),
                  ),
                  Text("Password"),
                  TextFormField(
                    controller: passwordController,
                    validator: validPassword,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: hidePassword
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          }),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: "  Password  ",
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        padding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      ),
                      child: Text("Login"),
                      onPressed: () {
                        if (validate()) {
                          print("validate");
                        } else {
                          print("not validate");
                        }
                      },
                    ),
                  ),
                ],
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
                    color: Colors.pink[200],
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //=========================== validation Function =========================
  String validUserName(String value) {
    if (value.trim().isEmpty) {
      return "Field can't be empty";
    } else if (value.trim().length < 4) {
      return "User Name Must Be More Than 4 ";
    } else {
      return null;
    }
  }

  String validPassword(String value) {
    if (value.trim().isEmpty) {
      return "Field Can't Be Empty";
    } else {
      return null;
    }
  }

  bool validate() {
    var formData = loginFormKey.currentState;
    if (formData.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
