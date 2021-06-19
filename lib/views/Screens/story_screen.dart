import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iread_flutter/views/Widgets/highlight_text.dart';

// ignore: must_be_immutable
class StoryScreen extends StatelessWidget {
  String strStory;
  StoryScreen({this.strStory});
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: h * 0.45,
          child: Stack(
            children: [
              Container(
                height: h * 0.45,
                child: Image.network(
                  "https://www.jotform.com/blog/wp-content/uploads/2018/07/photos-with-story-featured-15.jpg",
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Container(
                height: h * 0.45,
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.arrow_back,
                  size: 150,
                ),
              ),
              Transform.translate(
                offset: Offset(200, -140),
                child: Container(
                  child: Container(
                    child: Transform.scale(
                      scale: 1.2,
                      child: SvgPicture.asset(
                        "assets/images/shared/curve_top_right.svg",
                        color: Colors.orange[200],
                        alignment: Alignment.topLeft,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: h * 0.45,
                margin: EdgeInsets.all(40),
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 40,
                  color: Colors.purple,
                ),
              ),
              Container(
                height: 120,
                width: 120,
                alignment: Alignment.center,
                child: Icon(
                  Icons.menu,
                  color: Colors.purple,
                  size: 40,
                ),
              )
            ],
          ),
        ),
        Container(
          height: h * 0.30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.purple,
                    size: 40,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: HighlighText(marginX: w*0.15, marginY: h * 0.45-10),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.purple,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: h * 0.25,
          child: Transform.translate(
            offset: Offset(-w * 0.5, h * 0.1),
            child: Transform.scale(
              scale: 1.6,
              child: SvgPicture.asset(
                "assets/images/shared/curve_bottom_left.svg",
                color: Colors.pink[200],
                alignment: Alignment.topRight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
