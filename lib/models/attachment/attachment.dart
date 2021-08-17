import 'package:iread_flutter/models/model.dart';

class Attachment extends Model {
  String _title;
  String _downloadUrl;
  String _type;
  String _extension;
  double _size;
  DateTime _uploadDate;

  Attachment.fromJson(Map<String, dynamic> json) : super(id: json['id']) {
    _title = json['name'];
    _downloadUrl = json['downloadUrl'];
    _type = json['type'];
    _extension = json['extension'];
    _size = json['size'].toDouble();
    _uploadDate = DateTime.parse(json['uploadDate']);
  }
}
