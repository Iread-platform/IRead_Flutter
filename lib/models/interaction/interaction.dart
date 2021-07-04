class Interaction {
  int _storyId;
  String _studentId;
  int _pageId;

  Interaction.fromJson(Map<String, dynamic> json) {
    _storyId = json['storyId'];
    _studentId = json['studentId'];
    _pageId = json['pageId'];
  }

  int get storyId => _storyId;

  int get pageId => _pageId;

  String get studentId => _studentId;
}
