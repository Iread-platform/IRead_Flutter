import 'package:flutter/material.dart';
import 'package:iread_flutter/services/auth_service.dart';
import 'package:iread_flutter/utils/colors_utils.dart';
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
    final height = 130.0;

    return Container(
      height: height,
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20),
            child: Icon(
              IReadIcons.list,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          ),
          Container(
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: h * -0.18,
                  left: w * 0.25,
                  child: Transform.scale(
                    scale: 1.25,
                    child: Image.network(
                      AuthService().cU.imageUrl,
                      color: AppColors.IReadOrangeAccent,
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
                        name: AuthService().getUserFullName(),
                        progress: 5.0,
                        rank: 16,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
