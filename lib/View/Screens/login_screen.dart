import 'package:flutter/material.dart';

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
            height: h * 0.35,
            width: w,
            child: Stack(
              children: [
                Container(
                  height: h * 0.35 * 0.8,
                  width: w * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      radius: 75,
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
              height: h * 0.40,
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
              height: h * 0.25,
              width: w,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: w * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                      ),
                    ),
                    // child: SvgPicture.asset(
                    //   "assets/testSvg.svg",
                    //   height: 200,
                    //   semanticsLabel: 'A red up arrow',
                    // ),
                  ),
                ],
              )),
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
