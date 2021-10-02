class ReviewSubmit {
  String _userId;
  int _storyId;
  int _rate;

  ReviewSubmit(String userId, int storyId, int rate)
      : _userId = userId,
        _storyId = storyId,
        _rate = rate;
  ReviewSubmit.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _storyId = json['storyId'];
    _rate = json['rate'];
  }

  String get userId => userId;
  int get storyId => _storyId;
  int get rate => _rate;
}
