/// classId : -1
/// title : ""
/// archived : false

class Classes {
  int _classId;
  String _title;
  bool _archived;

  int get classId => _classId;
  String get title => _title;
  bool get archived => _archived;

  Classes({int classId, String title, bool archived}) {
    _classId = classId;
    _title = title;
    _archived = archived;
  }

  Classes.fromJson(dynamic json) {
    _classId = json["classId"];
    _title = json["title"];
    _archived = json["archived"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["classId"] = _classId;
    map["title"] = _title;
    map["archived"] = _archived;
    return map;
  }
}
