import 'dart:ui';

import 'package:flutter/material.dart';

class DrawingWidget extends StatefulWidget {
  const DrawingWidget({Key key}) : super(key: key);

  @override
  _DrawingWidgetState createState() => _DrawingWidgetState();
}

class _DrawingWidgetState extends State<DrawingWidget> {
  List<TouchPoints> points = [];
  StrokeCap strokeType = StrokeCap.butt;
  Color color = Colors.black;
  double opacity = 0.5;
  double strokeWidth = 2.0;
  bool closed = false;
  double minimalDistance = 2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
            size: Size.infinite, painter: FingerPainter(pointsList: points)),
        GestureDetector(
          onPanStart: (details) {
            if (closed) return;
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
              addPoint(renderBox, points[0].points);
            });
          },
        )
      ],
    );
  }

  void addPoint(RenderBox renderBox, Offset offset) {
    points.add(TouchPoints(
        points: renderBox.globalToLocal(offset),
        paint: Paint()
          ..strokeCap = strokeType
          ..isAntiAlias = true
          ..color = color.withOpacity(opacity)
          ..strokeWidth = strokeWidth));
  }

  void _checkDistance(RenderBox renderBox) {
    final length = points.length;
    Offset start = points[0].points;
    Offset end = points[length - 1].points;

    final distance = (end - start).distance;

    if (distance < minimalDistance && length > 5) {
      addPoint(renderBox, start);
      closed = true;
    }
  }
}

class FingerPainter extends CustomPainter {
  final List<TouchPoints> pointsList;
  final List<Offset> offsetPoints = [];

  FingerPainter({this.pointsList});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        //Drawing line when two consecutive points are available
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));

        //Draw points when two points are not next to each other
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(FingerPainter oldDelegate) => true;
}

class TouchPoints {
  Paint paint;
  Offset points;
  TouchPoints({this.points, this.paint});
}
