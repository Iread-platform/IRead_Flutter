import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                  Icons.menu_rounded,
                  size: 40,
                ),
              ),
              Container(
                height: h * 0.25,
                width: w * 0.8,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: h * 0.3,
                      width: w * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                      // child: SvgPicture.asset(
                      //   "assets/testSvg.svg",
                      //   height: 200,
                      //   semanticsLabel: 'A red up arrow',
                      // ),
                    ),
                    Container(
                        // color: Colors.amber,
                        width: w * 0.8,
                        // height: h*0.25,
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              width: w * 0.8 * 0.6,
                              child: Text("Mohamad AboAzan"),
                            ),
                            Container(
                              width: w * 0.8 * 0.4,
                              child: CircleAvatar(
                                radius: 45.0,
                                backgroundImage: NetworkImage(
                                    'https://cdn3.vectorstock.com/i/1000x1000/33/62/boy-kid-inside-circle-design-vector-11353362.jpg'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "subtitles",
                style: Theme.of(context).textTheme.headline4,
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  ),
                  child: Text("الكتب العربية"),
                  onPressed: () {},
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  ),
                  child: Text("English Book"),
                  onPressed: () {},
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  ),
                  child: Text("Francais Book"),
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
                  height: h * 0.3,
                  width: w * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100),
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
    ));
  }
}
