import 'package:flutter/material.dart';
import 'package:iread_flutter/themes/border_radius.dart';
import 'package:iread_flutter/views/widgets/shared/progress_bar.dart';
import 'package:iread_flutter/views/widgets/user/avatar.dart';

class Ranking extends StatelessWidget {
  final String _name;
  final double _progress;
  final int _rank;

  Ranking({@required name, @required progress, @required rank})
      : _name = name,
        _progress = progress,
        _rank = rank;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(
            imageUrl:
                'https://images.unsplash.com/flagged/photo-1573740144655-bbb6e88fb18a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=375&q=80',
            radius: 25,
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [Expanded(child: _rankingBar(context))],
          ),
        ],
      ),
    );
  }

  Widget _rankingBar(BuildContext context) {
    final progressBarWidth = 100.0;
    return Container(
      width: progressBarWidth + 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Text(
                    _name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: progressBarWidth - 10.0,
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            alignment: Alignment.center,
                            fit: BoxFit.fill,
                            image: AssetImage('images/shared/star.png'),
                          )),
                      child: Center(
                          child: Text(_rank.toString(),
                              style: Theme.of(context).textTheme.subtitle2))),
                ),
                Positioned(
                  top: 25,
                  left: 0,
                  child: Container(
                    width: progressBarWidth,
                    child: ProgressBar(
                      borderRadius: storyBorderRadius,
                      borderWidth: 1,
                      height: 12,
                      progress: _progress,
                      padding: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final x = size.width;
    final y = size.height;

    return Path()
      ..addPolygon([
        Offset(x * 0.5, y * 0),
        Offset(x * 0.61, y * 0.35),
        Offset(x * 0.98, y * 0.35),
        Offset(x * 0.68, y * 0.57),
        Offset(x * 0.79, y * 0.91),
        Offset(x * 0.5, y * 0.7),
        Offset(x * 0.21, y * 0.91),
        Offset(x * 0.32, y * 0.57),
        Offset(x * 0.02, y * 0.35),
        Offset(x * 0.39, y * 0.35),
      ], true);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
