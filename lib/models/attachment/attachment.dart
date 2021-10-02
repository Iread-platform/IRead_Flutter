import 'package:iread_flutter/models/model.dart';

class Attachment extends Model {
  String title;
  String downloadUrl;
  String type;
  String extension;
  double size;
  DateTime uploadDate;

  Attachment.fromJson(Map<String, dynamic> json) : super(id: json['id']) {
    title = json['name'];
    downloadUrl = json['downloadUrl'];
    type = json['type'];
    extension = json['extension'];
    size = json['size'].toDouble();
    uploadDate = DateTime.parse(json['uploadDate']);
  }

  DateTime get uploadDate => _uploadDate;

  double get size => _size;

  String get extension => _extension;

  String get type => _type;

  String get downloadUrl => _downloadUrl;

  String get title => _title;
}
