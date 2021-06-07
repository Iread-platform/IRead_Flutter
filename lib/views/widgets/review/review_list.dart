import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/review/rating_bar.dart';
import 'package:iread_flutter/views/widgets/user/avatar.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _review(context, 'https://picsum.photos/200/300', 3.5),
        SizedBox(
          height: 12,
        ),
        _review(context, 'https://picsum.photos/200/300', 4.2),
        SizedBox(
          height: 12,
        ),
        _review(context, 'https://picsum.photos/200/300', 2.8),
      ],
    );
  }

  Widget _review(BuildContext context, String imageUrl, double rating) => Row(
        children: [
          Column(
            children: [
              UserAvatar(
                imageUrl: imageUrl,
                radius: 40.0,
              ),
              Text(
                'User',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              )
            ],
          ),
          SizedBox(
            width: 12,
          ),
          RatingBar(rating: rating)
        ],
      );
}
