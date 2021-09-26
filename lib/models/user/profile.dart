import 'package:iread_flutter/models/school/SchoolMember.dart';

/// schoolMember : {"schoolId":6,"schoolTitle":"Hello","schoolMembershipType":"SchoolManager","classes":[{"classId":-1,"title":"","archived":false}]}
/// viewStories : null
/// firstName : "Yazan"
/// lastName : "Kassam"
/// id : "a8ced944-0e80-4932-9f47-42f4a05893d3"
/// role : "SchoolManager"
/// email : "wissam@manager.com"
/// level : 0
/// birthDay : "0001-01-01T00:00:00"
/// avatarAttachment : null
/// customPhotoAttachment : null

class Profile {
  SchoolMember _schoolMember;
  dynamic _viewStories;
  String _firstName;
  String _lastName;
  String _id;
  String _role;
  String _email;
  int _level;
  String _birthDay;
  dynamic _avatarAttachment;
  dynamic _customPhotoAttachment;

  SchoolMember get schoolMember => _schoolMember;
  dynamic get viewStories => _viewStories;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get id => _id;
  String get role => _role;
  String get email => _email;
  int get level => _level;
  String get birthDay => _birthDay;
  dynamic get avatarAttachment => _avatarAttachment;
  dynamic get customPhotoAttachment => _customPhotoAttachment;

  Profile(
      {SchoolMember schoolMember,
      dynamic viewStories,
      String firstName,
      String lastName,
      String id,
      String role,
      String email,
      int level,
      String birthDay,
      dynamic avatarAttachment,
      dynamic customPhotoAttachment}) {
    _schoolMember = schoolMember;
    _viewStories = viewStories;
    _firstName = firstName;
    _lastName = lastName;
    _id = id;
    _role = role;
    _email = email;
    _level = level;
    _birthDay = birthDay;
    _avatarAttachment = avatarAttachment;
    _customPhotoAttachment = customPhotoAttachment;
  }

  Profile.fromJson(dynamic json) {
    _schoolMember = json["schoolMember"] != null
        ? SchoolMember.fromJson(json["schoolMember"])
        : null;
    _viewStories = json["viewStories"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _id = json["id"];
    _role = json["role"];
    _email = json["email"];
    _level = json["level"];
    _birthDay = json["birthDay"];
    _avatarAttachment = json["avatarAttachment"];
    _customPhotoAttachment = json["customPhotoAttachment"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_schoolMember != null) {
      map["schoolMember"] = _schoolMember.toJson();
    }
    map["viewStories"] = _viewStories;
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["id"] = _id;
    map["role"] = _role;
    map["email"] = _email;
    map["level"] = _level;
    map["birthDay"] = _birthDay;
    map["avatarAttachment"] = _avatarAttachment;
    map["customPhotoAttachment"] = _customPhotoAttachment;
    return map;
  }
}
