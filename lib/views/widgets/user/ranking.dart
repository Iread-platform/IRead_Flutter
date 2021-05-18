import 'package:flutter/material.dart';
import 'package:iread_flutter/configs/themes/border_radius.dart';
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
          UserAvatar(
            imageUrl:
                'https://images.unsplash.com/flagged/photo-1573740144655-bbb6e88fb18a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=375&q=80',
            radius: 40.0,
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
                  top: 28,
                  left: 1,
                  child: Container(
                    width: progressBarWidth - 4,
                    child: Text(
                      _name,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: progressBarWidth - 12.0,
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            alignment: Alignment.center,
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/shared/star.png'),
                          )),
                      child: Center(
                          child: Text(_rank.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary)))),
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  child: Container(
                    width: progressBarWidth,
                    child: ProgressBar(
                      borderRadius: storyBorderRadius,
                      borderWidth: 1.0,
                      height: 12.0,
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
