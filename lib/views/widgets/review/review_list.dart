import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story/review.dart';
import 'package:iread_flutter/views/widgets/review/rating_bar.dart';
import 'package:iread_flutter/views/widgets/user/avatar.dart';

class ReviewList extends StatelessWidget {
  final List<Review> _reviews;

  ReviewList({List<Review> reviews, Key key})
      : _reviews = reviews ?? [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _reviews
            .map((e) => _review(context, e.userImage?.downloadUrl, e.rate,
                '${e.firstName} ${e.lastName}'))
            .toList()
            .sublist(0, _reviews.length > 3 ? 3 : _reviews.length));
  }

  Widget _review(
          BuildContext context, String imageUrl, double rating, String name) =>
      Row(
        children: [
          Column(
            children: [
              UserAvatar(
                imageUrl: imageUrl,
                radius: 40.0,
              ),
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(
                height: 12,
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
