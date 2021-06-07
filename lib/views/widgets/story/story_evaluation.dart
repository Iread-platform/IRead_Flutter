import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/user/avatar.dart';

class StoryEvaluation extends StatelessWidget {
  final String _evaluationHeader = 'Evaluation';

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
            imageUrl: 'https://picsum.photos/200/300',
            radius: 50.0,
          ),
          Text(
            'Student name',
            style: Theme.of(context).textTheme.headline5,
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
        ],
      ),
    );
  }
}
