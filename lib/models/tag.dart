import 'package:iread_flutter/models/model.dart';

class Tag extends Model {
  String _title;

  Tag.fromJson(Map<String, dynamic> json) : super(id: json['id']) {
    _title = json['title'];
  }

  get title => _title;
}
