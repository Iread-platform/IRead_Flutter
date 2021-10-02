import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:iread_flutter/models/attachment/attachment.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/models/model.dart';

class Polygon extends Model {
  List<Offset> _points;
  double _maxY, _minY, _maxX, _minX;
  bool saved = false;
  bool recordSaved = false;
  bool needToUpdate = false;
  String localRecordPath;
  String comment;
  Color color;
  int audioId;
  Attachment record;

  Polygon(
      {@required List<Offset> points,
      @required double maxY,
      @required double minY,
      @required double maxX,
      @required double minX,
      Color color})
      : _points = points,
        _maxY = maxY,
        _minY = minY,
        _maxX = maxX,
        _minX = minX,
        color = color ?? Colors.black87.withOpacity(0.5);

  Polygon.fromJson(Map<String, dynamic> json) : super(id: json['drawingId']) {
    final pointsString = jsonDecode(json['points']);

    _points = _pointsFromJson(pointsString);
    _maxX = json['maxX']?.toDouble() ?? 0;
    _maxY = json['maxX']?.toDouble() ?? 0;
    _minX = json['minX']?.toDouble() ?? 0;
    _minY = json['minY']?.toDouble() ?? 0;
    comment = json['comment'];
    audioId = json['audioId'].runtimeType == int ? json['audioId'] : null;
    color = Color(int.parse(json['color'], radix: 16)) ?? color;

    if (json['audio'] != null) {
      record = Attachment.fromJson(json['audio']);
      audioId = record.id;
      recordSaved = true;
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

  Polygon toStandardScreen(double width, double height) {
    List<Offset> standardPoints = [];
    standardPoints =
        points.map((e) => Offset(e.dx / width, e.dy / height)).toList();
    return Polygon(
        points: standardPoints,
        maxY: maxY / height,
        minY: minY / height,
        maxX: maxX / width,
        minX: minX / width)
      ..color = color;
  }

  Polygon toCurrentScreen(double width, double height) {
    List<Offset> drawPoints =
        points.map((e) => Offset(e.dx * width, e.dy * height)).toList();

    return Polygon(
        points: drawPoints,
        maxY: maxY * height,
        minY: minY * height,
        maxX: maxX * width,
        minX: minX * width)
      ..color = color;
  }
}
