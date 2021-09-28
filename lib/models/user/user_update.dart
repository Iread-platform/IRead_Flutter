/// firstName : "string"
/// lastName : "string"
/// email : "user@example.com"
/// avatarId : 0
/// customPhotoId : 0
/// birthDay : "2021-09-28T17:21:30.567Z"
/// level : 0

class UserUpdate {
  String _firstName;
  String _lastName;
  String _email;
  int _avatarId;
  int _customPhotoId;
  String _birthDay;
  int _level;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  int get avatarId => _avatarId;
  int get customPhotoId => _customPhotoId;
  String get birthDay => _birthDay;
  int get level => _level;

  UserUpdate({
      String firstName, 
      String lastName, 
      String email, 
      int avatarId, 
      int customPhotoId, 
      String birthDay, 
      int level}){
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _avatarId = avatarId;
    _customPhotoId = customPhotoId;
    _birthDay = birthDay;
    _level = level;
}

  UserUpdate.fromJson(dynamic json) {
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _email = json["email"];
    _avatarId = json["avatarId"];
    _customPhotoId = json["customPhotoId"];
    _birthDay = json["birthDay"];
    _level = json["level"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["email"] = _email;
    map["avatarId"] = _avatarId;
    map["customPhotoId"] = _customPhotoId;
    map["birthDay"] = _birthDay;
    map["level"] = _level;
    return map;
  }

}