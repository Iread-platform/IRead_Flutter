import 'package:flutter/cupertino.dart';
import 'package:iread_flutter/models/model.dart';

class Polygon extends Model {
  List<Offset> _points;
  double _maxY, _minY, _maxX, _minX;
  bool saved = false;

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

  get minX => _minX;

  get maxX => _maxX;

  get minY => _minY;

  double get maxY => _maxY;

  List<Offset> get points => _points;
}
