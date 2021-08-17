import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:iread_flutter/models/attachment/attachment.dart';
import 'package:iread_flutter/models/model.dart';

class Polygon extends Model {
  List<Offset> _points;
  double _maxY, _minY, _maxX, _minX;
  bool saved = false;
  bool recordSaved = false;
  bool needToUpdate = false;
  int audioId;
  String localRecordPath;
  String comment;
  Attachment record;

  Polygon(
      {@required List<Offset> points,
      @required double maxY,
      @required double minY,
      @required double maxX,
      @required double minX})
      : _points = points,
        _maxY = maxY,
        _minY = minY,
        _maxX = maxX,
        _minX = minX;

  Polygon.fromJson(Map<String, dynamic> json) : super(id: json['drawingId']) {
    final pointsString = jsonDecode(json['points']);

    _points = _pointsFromJson(pointsString);
    _maxX = json['maxX'].toDouble();
    _maxY = json['maxX'].toDouble();
    _minX = json['minX'].toDouble();
    _minY = json['minY'].toDouble();
    comment = json['comment'];
    audioId = json['audioId'].runtimeType == int ? json['audioId'] : null;

    if (audioId != null) {
      recordSaved = true;
      //TODO fetch attachment
      //localRecordPath = FileUtils.localPath +
    }

    saved = true;
  }

  set setId(int id) => this.id = id;

  double get minX => _minX;

  double get maxX => _maxX;

  double get minY => _minY;

  double get maxY => _maxY;

  List<Offset> get points => _points;

  List<Map<String, dynamic>> pointsToJson() {
    List<Map<String, dynamic>> jsonPoints = [];

    points.forEach((element) {
      final point = {"x": element.dx, "y": element.dy};

      jsonPoints.add(point);
    });

    return jsonPoints;
  }

  List<Offset> _pointsFromJson(List<dynamic> json) {
    List<Offset> points = [];

    for (final point in json) {
      points.add(Offset(point['x'], point['y']));
    }

    return points;
  }
}
