import 'dart:convert';

import 'package:iread_flutter/models/attachment/attachment.dart';

class Review {
  int _reviewId;
  double _rate;
  String _firstName;
  String _lastName;
  Attachment _userImage;

  Review.fromJson(Map<String, dynamic> json) {
    _reviewId = json['reviewId'];
    _rate = json['rate'].toDouble();
    _firstName = json['firstName'];
    _lastName = json['lastName'];

    if (json['userImage'] != null) {
      _userImage = Attachment.fromJson(json['userImage']);
    }
  }

  Map<String, dynamic> toJson() => {
        'reviewId': _reviewId,
        'rate': _rate,
        'firstName': _firstName,
        'lastName': _lastName,
        'userImage': jsonEncode(_userImage)
      };

  Attachment get userImage => _userImage;

  String get lastName => _lastName;

  String get firstName => _firstName;

  double get rate => _rate;

  int get reviewId => _reviewId;
}
