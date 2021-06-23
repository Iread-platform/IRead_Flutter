import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/models/draw/polygon.dart';

class DrawingWidget extends StatefulWidget {
  final List<Polygon> _polygons;
  DrawingWidget({Key key, List<Polygon> polygons})
      : _polygons = polygons ?? [],
        super(key: key);

  @override
  _DrawingWidgetState createState() => _DrawingWidgetState();
}

class _DrawingWidgetState extends State<DrawingWidget> {
  List<Offset> points = [];
  double maxY, minY, maxX, minX;

  Paint paint = Paint()
    ..strokeWidth = 4
    ..color = Colors.black45.withOpacity(0.5)
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;
  bool closed = false;
  double minimalDistance = 2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
            size: Size.infinite,
            painter:
                FingerPainter(points: points, closed: closed, paint: paint)),
        GestureDetector(
          onPanStart: (details) {
            setState(
              () {
                RenderBox renderBox = context.findRenderObject();
                addPoint(renderBox, details.globalPosition);
              },
            );
          },
          onPanUpdate: (details) {
            if (closed) return;
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              addPoint(renderBox, details.globalPosition);
              _checkDistance(renderBox);
            });
          },
          onPanEnd: (details) {
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              closed = true;
              addPoint(renderBox, points[0]);
              widget._polygons.add(Polygon(
                  points: points,
                  maxY: maxY,
                  minY: minY,
                  maxX: maxX,
                  minX: minX));
            });
          },
        )
      ],
    );
  }

  void addPoint(RenderBox renderBox, Offset offset) {
    Offset point = renderBox.globalToLocal(offset);
    // Store min/max X and Y for a polygon.
    final double x = point.dx;
    final double y = point.dy;
    if (points.length == 0) {
      maxY = minY = y;
      maxX = minX = x;
    } else {
      maxX = max(maxX, x);
      minX = min(minX, x);
      maxY = max(maxY, y);
      minY = min(minY, y);
    }

    points.add(point);
  }

  void _checkDistance(RenderBox renderBox) {
    final length = points.length;
    Offset start = points[0];
    Offset end = points[length - 1];

    final distance = (end - start).distance;

    if (distance < minimalDistance && length > 5) {
      addPoint(renderBox, start);
      closed = true;
    }
  }
}

class FingerPainter extends CustomPainter {
  final List<Offset> pointsList;
  final List<Offset> offsetPoints = [];
  Paint paintData;
  bool closed = false;

  FingerPainter({@required List<Offset> points, Paint paint, bool closed})
      : pointsList = points,
        paintData = paint ?? Paint()
          ..style = PaintingStyle.fill
          ..strokeCap = StrokeCap.butt
          ..isAntiAlias = true
          ..color = Colors.black12.withOpacity(0.5),
        closed = closed;

  @override
  void paint(Canvas canvas, Size size) {
    closed ? _drawPolygon(canvas, size) : _drawLines(canvas, size);
  }

  void _drawLines(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        //Drawing line when two consecutive points are available
        canvas.drawLine(
            pointsList[i],
            pointsList[i + 1],
            Paint()
              ..color = paintData.color
              ..style = paintData.style
              ..strokeCap = paintData.strokeCap
              ..strokeWidth = paintData.strokeWidth
              ..isAntiAlias = paintData.isAntiAlias);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i]);
        offsetPoints
            .add(Offset(pointsList[i].dx + 0.1, pointsList[i].dy + 0.1));

        //Draw points when two points are not next to each other
        canvas.drawPoints(
            PointMode.points,
            offsetPoints,
            Paint()
              ..color = paintData.color
              ..style = paintData.style
              ..strokeCap = paintData.strokeCap
              ..strokeWidth = paintData.strokeWidth
              ..isAntiAlias = paintData.isAntiAlias);
      }
    }
  }

  void _drawPolygon(Canvas canvas, Size size) {
    final Path path = Path();
    path.addPolygon(pointsList, true);
    canvas.drawPath(path, paintData);
  }

  @override
  bool shouldRepaint(FingerPainter oldDelegate) => true;
}
