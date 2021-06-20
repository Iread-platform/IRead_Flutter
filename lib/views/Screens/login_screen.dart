import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iread_flutter/utils/validator.dart';

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
                  offset: Offset(0, -h * 0.05),
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
                    height: h * 0.4,
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.orangeAccent,
                      backgroundImage: NetworkImage(
                          'https://thumbs.dreamstime.com/b/man-hipster-avatar-cartoon-guy-black-hair-flat-icon-blue-background-user-person-character-vector-illustration-185480506.jpg'),
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
                    validator: Validator.validUserName,
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
                    validator: Validator.validPassword,
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

  bool validate() {
    var formData = loginFormKey.currentState;
    if (formData.validate()) {
      return true;
    } else {
      return false;
    }
  }
}
