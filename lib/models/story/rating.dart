/// averageOfRates : 4
/// reviewsCount : 1

class Rating {
  int _averageOfRates;
  int _reviewsCount;

  int get averageOfRates => _averageOfRates;
  int get reviewsCount => _reviewsCount;

  Rating({int averageOfRates, int reviewsCount}) {
    _averageOfRates = averageOfRates;
    _reviewsCount = reviewsCount;
  }

  Rating.fromJson(dynamic json) {
    _averageOfRates = json["averageOfRates"];
    _reviewsCount = json["reviewsCount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["averageOfRates"] = _averageOfRates;
    map["reviewsCount"] = _reviewsCount;
    return map;
  }
}
