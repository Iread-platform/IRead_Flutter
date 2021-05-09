import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
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
            color: Colors.white,
            child: Stack(
              children: [
                Container(
                  height: h * 0.35 * 0.8,
                  width: w * 0.60,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Container(
                  height: h * 0.9,
                  padding: EdgeInsets.all(50),
                  child: Center(
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundImage: NetworkImage(
                          'https://thumbs.dreamstime.com/b/man-hipster-avatar-cartoon-guy-black-hair-flat-icon-blue-background-user-person-character-vector-illustration-185480506.jpg'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //==================== Text Fileds ===========================
          Container(
            height: h * 0.40,
            width: w * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("User Name"),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: "User Name",
                  ),
                ),
                Text("User Name"),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: "User Name",
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
                    onPressed: () {},
                  ),
                )
              ],
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
              ))
        ],
      ),
    );
  }
}
