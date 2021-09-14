import 'package:iread_flutter/models/model.dart';

class User {
  String _id;
  String _email;
  String _firstName;
  String _lastName;
  String _imageUrl;
  String _token;
  UserRole _userRole;

  User({String id,String email,String firstName, String lastName, String imageUrl, String token, UserRole userRole})
      : _firstName = firstName,
        _lastName = lastName,
        _imageUrl = imageUrl,
        _token = token,
        _id = id,
        _email = email,
        _userRole = userRole;

  User.fromJson(Map<String, dynamic> json)
  {
    _id = json['id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _imageUrl = json['imageUrl'];
    _token = json['token'];
    _email = json['email'];
    _userRole = UserRole.values.firstWhere((element) => element.toString() == json['userRole']);
  }

  get firstName => _firstName;
  get lastName => _lastName;
  get imageUrl => _imageUrl;
  get userRole => _userRole;
  get token => _token;
  get id => _id;
  get email => _email;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    data['imageUrl'] = this._imageUrl;
    data['userRole'] = this._userRole.toString();
    data['token'] = this._token;
    data['email'] = this._email;
    return data;
  }


}

enum UserRole { Admin, Teacher, Student, SchoolManager }
