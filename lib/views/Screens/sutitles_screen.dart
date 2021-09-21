import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/user/avatar.dart';

class SubtitlesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        //======================== header  (image-name-menu) ===============================
        Container(
          height: h * 0.25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: w * 0.2,
                height: h * 0.3 * 0.8,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Icon(
                  IReadIcons.list,
                  color: Theme.of(context).primaryColor,
                  size: 40,
                ),
              ),
              Container(
                height: h * 0.25,
                width: w * 0.8,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Transform.translate(
                      offset: Offset(w * 0.08, -h * 0.01),
                      child: Transform.scale(
                        scale: 1.25,
                        child: SvgPicture.asset(
                          "assets/images/shared/curve_top_right.svg",
                          color: Colors.orangeAccent,
                          alignment: Alignment.topRight,
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              width: w * 0.8 * 0.6,
                              child: Text("Mohamad AboAzan"),
                            ),
                            Container(
                              width: w * 0.8 * 0.4,
                              child: UserAvatar(
                                imageUrl:
                                    "https://cdn3.vectorstock.com/i/1000x1000/33/62/boy-kid-inside-circle-design-vector-11353362.jpg",
                                radius: 70.3,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        // ========================= subtitles (Ar,En,Fr) =======================
        Container(
          height: h * 0.5,
          width: w * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: w * 0.7,
                child: Text(
                  "subtitles",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: Container(
                    alignment: Alignment.center,
                    width: w * 0.6,
                    height: 50,
                    child: Text("الكتب العربية"),
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: Container(
                    alignment: Alignment.center,
                    width: w * 0.6,
                    height: 50,
                    child: Text("English Book"),
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(),
                  child: Container(
                    alignment: Alignment.center,
                    width: w * 0.6,
                    height: 50,
                    child: Text("Francais Book"),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        // ======================== Footer ========================
        Container(
            height: h * 0.25,
            width: w,
            child: Stack(
              children: [
                Container(
                  width: w * 0.6,
                  child: Transform.translate(
                    offset: Offset(-w * 0.1, h * 0.1),
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
            ))
      ],
    ));
  }
}
