class ReviewSubmit {
  int _storyId;
  int _rate;

  ReviewSubmit(String userId, int storyId, int rate)
      : _storyId = storyId,
        _rate = rate;
  ReviewSubmit.fromJson(Map<String, dynamic> json) {
    _storyId = json['storyId'];
    _rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    return {'storyId': _storyId, 'rate': _rate};
  }

  int get storyId => _storyId;
  int get rate => _rate;
}
