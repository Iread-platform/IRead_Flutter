import 'package:flutter/cupertino.dart';
import 'package:iread_flutter/models/model.dart';

class Polygon extends Model {
  List<Offset> _points;
  double _maxY, _minY, _maxX, _minX;
  bool saved = false;
  int _audioId;
  String localRecordPath;
  String comment;

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

  Polygon.fromJson(Map<String, dynamic> json) {
    final pointsString = json['points'];

    _points = _pointsFromJson(pointsString);
    _maxX = json['maxX'];
    _maxY = json['maxX'];
    _minX = json['minX'];
    _minY = json['minY'];
    comment = json['comment'];
    _audioId = json['audioId'];

    saved = true;
  }

  set setId(int id) => this.id = id;

  get minX => _minX;

  get maxX => _maxX;

  get minY => _minY;

  get audioId => _audioId;

  double get maxY => _maxY;

  List<Offset> get points => _points;

  List<Map<String, dynamic>> pointsToJson() {
    List<Map<String, dynamic>> jsonPoints = [];

    points.forEach((element) {
      final point = {"x": element.dx, "Y": element.dy};

      jsonPoints.add(point);
    });

    return jsonPoints;
  }

  List<Offset> _pointsFromJson(List<Map<String, dynamic>> json) {
    List<Offset> points = [];

    for (final point in json) {
      points.add(Offset(point['x'], point['y']));
    }

    return points;
  }
}
