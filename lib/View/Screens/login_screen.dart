import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: h * 0.35,
          width: w,
          color: Colors.red,
          child: Stack(
            children: [
              Container(
                height: h * 0.35 * 0.8,
                width: w * 0.55,
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50))),
              ),
            ],
          ),
        ),
        Container(
          height: h * 0.40,
          color: Colors.white,
        ),
        Container(
          height: h * 0.25,
          color: Colors.purple,
        ),
      ],
    );
  }
}
