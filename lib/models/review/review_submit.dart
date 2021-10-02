class Review {
  String _userId;
  int _storyId;
  int _rate;

  Review(String userId, int storyId, int rate)
      : _userId = userId,
        _storyId = storyId,
        _rate = rate;
  Review.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _storyId = json['storyId'];
    _rate = json['rate'];
  }
}
