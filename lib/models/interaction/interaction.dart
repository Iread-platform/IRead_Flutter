class Interaction {
  int _storyId;
  String _studentId;
  int _pageId;

  Interaction.fromJson(Map<String, dynamic> json) {
    _storyId = json['storyId'];
    _studentId = json['studentId'];
    _pageId = json['pageId'];
  }

  Interaction(this._studentId, this._pageId, this._storyId);

  int get storyId => _storyId;

  int get pageId => _pageId;

  Map<String, dynamic> get json =>
      {"storyId": _storyId, "studentId": _studentId, "pageId": _pageId};

  String get studentId => _studentId;
}
