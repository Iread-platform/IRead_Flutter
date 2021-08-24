import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/user/ranking.dart';

class IreadAppBar extends StatefulWidget {
  const IreadAppBar({Key key}) : super(key: key);

  @override
  _IreadAppBarState createState() => _IreadAppBarState();
}

class _IreadAppBarState extends State<IreadAppBar> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final height = h * 0.25;

    return Container(
      height: height,
      child: Column(
        children: [
          Row(
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
                  size: 30,
                ),
              ),
              Container(
                height: h * 0.20,
                width: w * 0.8,
                child: Stack(
                  alignment: Alignment.topRight,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: h * -0.09,
                      left: w * 0.35,
                      child: Transform.scale(
                        scale: 1.25,
                        child: SvgPicture.asset(
                          "assets/images/shared/curve_top_right.svg",
                          color: Colors.orangeAccent,
                          alignment: Alignment.topRight,
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                          margin: EdgeInsets.only(right: 20),
                          alignment: Alignment.center,
                          child: Ranking(
                            name: "Mohamad",
                            progress: 5.0,
                            rank: 16,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
