import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';

class RatingBar extends StatelessWidget {
  final double _rating;

  const RatingBar({@required double rating, Key key})
      : _rating = rating,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: _rating,
      itemCount: 5,
      itemSize: 24,
      unratedColor: Colors.black12,
      itemPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      itemBuilder: (BuildContext context, int index) => Icon(
        IReadIcons.star,
        color: Colors.amberAccent,
      ),
    );
  }
}
