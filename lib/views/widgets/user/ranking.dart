import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import 'package:iread_flutter/config/themes/border_radius.dart';
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
      height: 75.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: UserAvatar(
              showShadow: true,
              imageUrl:
              'https://thumbs.dreamstime.com/b/man-hipster-avatar-cartoon-guy-black-hair-flat-icon-blue-background-user-person-character-vector-illustration-185480506.jpg',
              radius: 45.0,
            ),
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
    final progressBarWidth = 150.0;
    return Container(
      width: progressBarWidth + 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 30,
                  right: 0,
                  child: Container(
                    width: progressBarWidth,
                    child: Text(
                      _name,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Positioned(
                  top: 33,
                  left: 0,
                  child: Stack(
                    children: [
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(-8 / 360),
                        child: SvgPicture.asset("assets/images/shared/star.svg",
                          width: 40,
                        ),
                      ),
                      Container(
                          width: 40,
                          height: 40,
                          child: Center(
                              child: Text(_rank.toString(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                  fontSize: 15))
                          )
                      )
                    ]
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 30,
                  child: Container(
                    width: progressBarWidth + 10,
                    child: ProgressBar(
                      borderRadius: storyBorderRadius,
                      borderWidth: 1.0,
                      height: 13.0,
                      progress: _progress,
                      padding: 2.0,
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
