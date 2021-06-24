import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/drawing_bloc/drawing_bloc.dart';
import 'package:iread_flutter/bloc/record_bloc/record_bloc.dart';
import 'package:iread_flutter/bloc/record_bloc/record_events.dart';
import 'package:iread_flutter/bloc/record_bloc/record_state.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';
import 'package:iread_flutter/config/themes/shadows.dart';
import 'package:iread_flutter/models/draw/polygon.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';

class DrawingWidget extends StatefulWidget {
  DrawingWidget({Key key}) : super(key: key);

  @override
  _DrawingWidgetState createState() => _DrawingWidgetState();
}

class _DrawingWidgetState extends State<DrawingWidget> {
  List<Offset> points = [];
  double maxY, minY, maxX, minX;
  DrawingBloc _drawBloc;
  RecordBloc _recordBloc;
  // Paint style
  Paint paint = Paint()
    ..strokeWidth = 4
    ..color = Colors.black45.withOpacity(0.5)
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;
  bool closed = false;
  double minimalDistance = 2;

  @override
  void initState() {
    super.initState();
    _drawBloc = BlocProvider.of<DrawingBloc>(context);
    _recordBloc = BlocProvider.of<RecordBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _customPaint(),
        _gestureDetector(),
        _drawBloc.polygons.length > 0
            ? _drawActions(context, _drawBloc.polygons[0], 0)
            : SizedBox()
      ],
    );
  }

  Widget _customPaint() => CustomPaint(
      size: Size.infinite,
      painter: FingerPainter(
          polygons: _drawBloc.polygons,
          points: points,
          closed: closed,
          paint: paint));

  GestureDetector _gestureDetector() => GestureDetector(
        onPanStart: (details) {
          setState(
            () {
              if (closed) {
                return;
              }
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
            _drawBloc.addPolygon(Polygon(
                points: List<Offset>.from(points),
                maxY: maxY,
                minY: minY,
                maxX: maxX,
                minX: minX));
            points.clear();
          });
        },
      );

  Widget _drawActions(BuildContext context, Polygon polygon, int index) {
    double x = (polygon.maxX + polygon.minX) / 2;
    double y = polygon.minY;

    return Positioned(
      top: y,
      left: x,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(storyBorderRadius),
          boxShadow: [mediumBottomRightShadow],
        ),
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.save_alt), onPressed: () {}),
            BlocBuilder<RecordBloc, BlocState>(builder: (context, state) {
              switch (state.runtimeType) {
                case RecordingState:
                  {
                    return IconButton(
                        icon: Icon(Icons.pause), onPressed: () {});
                  }
                  break;
              }
              return IconButton(
                  icon: Icon(IReadIcons.microphone),
                  onPressed: () {
                    _recordBloc.add(RecordEvent());
                  });
            }),
            IconButton(
                icon: Icon(IReadIcons.delete),
                onPressed: () {
                  setState(() {
                    _drawBloc.deletePolygon(index);
                    closed = false;
                  });
                })
          ],
        ),
      ),
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
  final List<Polygon> _polygons;
  final List<Offset> pointsList;
  final List<Offset> offsetPoints = [];
  Paint paintData;
  bool closed = false;

  FingerPainter(
      {@required List<Offset> points,
      @required polygons,
      Paint paint,
      bool closed})
      : _polygons = polygons,
        pointsList = points,
        paintData = paint ?? Paint()
          ..style = PaintingStyle.fill
          ..strokeCap = StrokeCap.butt
          ..isAntiAlias = true
          ..color = Colors.black12.withOpacity(0.5),
        closed = closed;

  @override
  void paint(Canvas canvas, Size size) {
    _drawLines(canvas, size);
    _drawPolygon(canvas, size);
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
    _polygons.forEach((element) {
      path.addPolygon(element.points, true);
    });
    canvas.drawPath(path, paintData);
  }

  @override
  bool shouldRepaint(FingerPainter oldDelegate) => true;
}
