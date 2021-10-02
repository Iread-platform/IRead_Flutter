import 'package:iread_flutter/models/school/Class.dart';

/// schoolId : 6
/// schoolTitle : "Hello"
/// schoolMembershipType : "SchoolManager"
/// classes : [{"classId":-1,"title":"","archived":false}]

class SchoolMember {
  int _schoolId;
  String _schoolTitle;
  String _schoolMembershipType;
  List<Classes> _classes;

  int get schoolId => _schoolId;
  String get schoolTitle => _schoolTitle;
  String get schoolMembershipType => _schoolMembershipType;
  List<Classes> get classes => _classes;

  SchoolMember(
      {int schoolId,
      String schoolTitle,
      String schoolMembershipType,
      List<Classes> classes}) {
    _schoolId = schoolId;
    _schoolTitle = schoolTitle;
    _schoolMembershipType = schoolMembershipType;
    _classes = classes;
  }

  SchoolMember.fromJson(dynamic json) {
    _schoolId = json["schoolId"];
    _schoolTitle = json["schoolTitle"];
    _schoolMembershipType = json["schoolMembershipType"];
    if (json["classes"] != null) {
      _classes = [];
      json["classes"].forEach((v) {
        _classes.add(Classes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["schoolId"] = _schoolId;
    map["schoolTitle"] = _schoolTitle;
    map["schoolMembershipType"] = _schoolMembershipType;
    if (_classes != null) {
      map["classes"] = _classes.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
