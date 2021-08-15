import 'package:iread_flutter/models/model.dart';

class User extends Model {
  String _name;
  String _imageUrl;

  User({String name, String imageUrl})
      : _name = name,
        _imageUrl = imageUrl;

  User.fromJson(Map<String, dynamic> json) {}

  get name => _name;
  get imageUrl => _imageUrl;
}
