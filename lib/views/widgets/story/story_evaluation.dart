import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/review/review_list.dart';
import 'package:iread_flutter/views/widgets/user/avatar.dart';

import '../../../main.dart';

class StoryEvaluation extends StatelessWidget {
  final String _evaluationHeader = 'Evaluation';
  final String _evaluateLabel = 'Evaluate';

  const StoryEvaluation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            _evaluationHeader,
            style: Theme.of(context).textTheme.headline4,
          ),
          UserAvatar(
            imageUrl: user.imageUrl,
            radius: 50.0,
          ),
          Text(
            user.name,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 8,
          ),
          RatingBar.builder(
              itemSize: 24,
              itemCount: 5,
              glowColor: Colors.amberAccent,
              minRating: 1,
              initialRating: 1,
              unratedColor: Colors.black12,
              itemBuilder: (context, index) => Icon(
                    IReadIcons.star,
                    color: Colors.amber,
                  ),
              onRatingUpdate: (rating) {}),
          SizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              _evaluateLabel,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Theme.of(context).colorScheme.surface),
            ),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          ReviewList()
        ],
      ),
    );
  }
}
