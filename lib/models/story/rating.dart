import 'package:iread_flutter/models/story/review.dart';

/// averageOfRates : 4
/// reviewsCount : 1

class Rating {
  int _averageOfRates;
  int _reviewsCount;
  List<Review> _reviews;

  int get averageOfRates => _averageOfRates;
  int get reviewsCount => _reviewsCount;
  List<Review> get reviews => _reviews;

  Rating({int averageOfRates, int reviewsCount}) {
    _averageOfRates = averageOfRates;
    _reviewsCount = reviewsCount;
  }

  Rating.fromJson(Map<String, dynamic> json) {
    _averageOfRates = json["averageOfRates"];
    _reviewsCount = json["reviewsCount"];

    if (json['reviews'] != null) {
      _reviews = [];
      for (final jsonReview in json['reviews']) {
        final review = Review.fromJson(jsonReview);
        _reviews.add(review);
      }
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["averageOfRates"] = _averageOfRates;
    map["reviewsCount"] = _reviewsCount;
    return map;
  }
}
