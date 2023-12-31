import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/comment_bloc/comment_bloc.dart';
import 'package:iread_flutter/bloc/comment_bloc/comment_events.dart';
import 'package:iread_flutter/bloc/drawing_bloc/drawing_bloc.dart';
import 'package:iread_flutter/bloc/drawing_bloc/drawing_events.dart';
import 'package:iread_flutter/bloc/drawing_bloc/drawing_states.dart';
import 'package:iread_flutter/bloc/record_bloc/record_bloc.dart';
import 'package:iread_flutter/bloc/record_bloc/record_events.dart';
import 'package:iread_flutter/bloc/record_bloc/record_state.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';
import 'package:iread_flutter/config/themes/shadows.dart';
import 'package:iread_flutter/models/draw/polygon.dart';
import 'package:iread_flutter/utils/extensions.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/shared/confirm_alert.dart';
import 'package:iread_flutter/views/widgets/shared/request_handler.dart';

class DrawingWidget extends StatefulWidget {
  final TextEditingController _comment = new TextEditingController();
  final String _imageUrl;

  DrawingWidget({Key key, @required String imageUrl})
      : _imageUrl = imageUrl,
        super(key: key);

  @override
  _DrawingWidgetState createState() => _DrawingWidgetState();
}

class _DrawingWidgetState extends State<DrawingWidget> {
  List<Offset> points = [];
  double maxY, minY, maxX, minX;
  DrawingBloc _drawBloc;
  RecordBloc _recordBloc;
  CommentBloc _commentBloc;

  // Paint style
  Paint paint = Paint()
    ..strokeWidth = 4
    ..color = Colors.black45.withOpacity(0.5)
    ..isAntiAlias = true
    ..style = PaintingStyle.fill;
  double minimalDistance = 2;

  @override
  void initState() {
    super.initState();
    _drawBloc = BlocProvider.of<DrawingBloc>(context);
    _recordBloc = BlocProvider.of<RecordBloc>(context);
    _commentBloc = BlocProvider.of<CommentBloc>(context);
    _drawBloc.recordBloc = _recordBloc;
  }

  @override
  Widget build(BuildContext context) {
    _drawBloc.screenWidth = MediaQuery.of(context).size.width;
    _drawBloc.screenHeight = MediaQuery.of(context).size.height;

    return RequestHandler(
        bloc: _drawBloc,
        isDismissible: true,
        main: Container(
          child: Image.network(
            widget._imageUrl,
            fit: BoxFit.contain,
          ),
        ),
        onSuccess: (context, state) {
          if (state is PolygonSavingState) {
            _drawBloc.canInteract = false;
          } else if (state is PolygonSavedState || state is PolygonFailState) {
            _drawBloc.canInteract = true;
          }

          // Update color
          paint.color = _drawBloc.selectedPolygon?.color ?? _drawBloc.color;

          return Container(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned.fill(child: _customPaint()),
                Positioned.fill(child: _gestureDetector()),
                _drawBloc.polygons.length < 1
                    ? _colorPickerButton()
                    : SizedBox(),
                _drawBloc.polygons.length > 0 ||
                        state.runtimeType == DrawPolygonState
                    ? _drawActions(
                        context, _drawBloc.selectedPolygonForDraw, 0, state)
                    : SizedBox()
              ],
            ),
          );
        });
  }

  Widget _customPaint() => CustomPaint(
      size: Size.infinite,
      painter: FingerPainter(
          polygons: _drawBloc.polygons,
          points: points,
          closed: _drawBloc.closed,
          paint: paint));

  GestureDetector _gestureDetector() => GestureDetector(
        onPanStart: (details) {
          setState(
            () {
              if (_drawBloc.closed) {
                Fluttertoast.showToast(msg: "You can't draw another one.");
                return;
              }
              _recordBloc.add(ResetEvent());
              RenderBox renderBox = context.findRenderObject();
              addPoint(renderBox, details.globalPosition);
            },
          );
        },
        onPanUpdate: (details) {
          if (_drawBloc.closed) return;
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            addPoint(renderBox, details.globalPosition);
            _checkDistance(renderBox);
          });
        },
        onPanEnd: (details) {
          if (_drawBloc.closed) {
            return;
          }

          setState(() {
            RenderBox renderBox = context.findRenderObject();
            _drawBloc.closed = true;
            addPoint(renderBox, points[0]);
            _drawBloc.addPolygon(Polygon(
                points: List<Offset>.from(points),
                maxY: maxY,
                minY: minY,
                maxX: maxX,
                minX: minX,
                color: _drawBloc.color));
            points.clear();
          });
        },
      );

  Widget _drawActions(
      BuildContext context, Polygon polygon, int index, BlocState state) {
    double offsetX = 225;
    double offsetY = 50;
    double x = (polygon.maxX + polygon.minX) / 2;
    double y = polygon.minY;

    final size = MediaQuery.of(context).size;

    if (y <= offsetY) {
      y = offsetY;
    }

    if (x > size.width - offsetX) {
      x = size.width - offsetX;
    }

    if (state is LoadingState) {
      return Positioned(
        top: y,
        left: x,
        child: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

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
            _showSaveButton(context, state),
            _recordingBuilder(context),
            _commentBuilder(context),
            _deleteButton(context, state)
          ],
        ),
      ),
    );
  }

  _showSaveButton(BuildContext context, BlocState state) {
    if (state.runtimeType == PolygonRecordSaved) {
      return Tooltip(
        message: 'Your record has saved',
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CircularProgressIndicator()),
      );
    } else if (state.runtimeType == PolygonSavingState) {
      return Tooltip(
        message: 'Saving your draw',
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CircularProgressIndicator()),
      );
    } else if (state.runtimeType == PolygonFailState) {
      return Tooltip(
          message: 'Can not sync your polygon, press to retry',
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: IconButton(
                  icon: Icon(Icons.refresh),
                  color: Theme.of(context).colorScheme.primaryVariant,
                  onPressed: () {
                    _drawBloc.add(_drawBloc.lastEvent);
                  })));
    }
    // Save the selected polygon with attachments
    return _drawBloc.selectedPolygon.saved
        ? Tooltip(
            message: 'Your draw has been saved',
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  Icons.check,
                  color: Colors.green,
                )),
          )
        : Tooltip(
            message: "Save your draw",
            child: IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  _drawBloc.add(SavePolygonEvent());
                }),
          );
  }

  Widget _commentBuilder(BuildContext context) {
    return BlocBuilder<CommentBloc, BlocState>(
      builder: (context, state) {
        if (_drawBloc.selectedPolygon.comment != null) {
          return DropdownButton(
            hint: Icon(Icons.edit),
            items: [
              DropdownMenuItem(
                  child: Center(child: Icon(Icons.edit)), value: "show"),
              DropdownMenuItem(
                  child: Center(child: Icon(IReadIcons.delete)),
                  value: "delete")
            ],
            onChanged: _drawBloc.canInteract
                ? (value) {
                    if (value == "show") {
                      _showCommentDialog(context);
                    } else if (value == "delete") {
                      _deleteComment();
                    }
                  }
                : null,
          );
        }

        return Tooltip(
          message: "Add a comment",
          child: IconButton(
              icon: Icon(Icons.edit),
              onPressed: _drawBloc.canInteract
                  ? () {
                      widget._comment.clear();

                      _showCommentDialog(context);
                    }
                  : null),
        );
      },
    );
  }

  Future<void> _showCommentDialog(BuildContext buildContext) {
    widget._comment.text = _drawBloc.selectedPolygon.comment;
    return showDialog<String>(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Your comment",
              style: Theme.of(context).textTheme.headline4,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: widget._comment,
                  onSubmitted: _addComment,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () =>
                            _addComment(widget._comment.value.text),
                        child: Text(
                          !_drawBloc.selectedPolygon.comment.isNullOrEmpty()
                              ? "Update"
                              : "Add",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Theme.of(context).colorScheme.surface),
                        )),
                    SizedBox(
                      width: 12,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          if (!_drawBloc.selectedPolygon.comment
                              .isNullOrEmpty()) {
                            _deleteComment();
                          }
                        },
                        child: Text(
                          !_drawBloc.selectedPolygon.comment.isNullOrEmpty()
                              ? "Delete"
                              : "cancel",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: Theme.of(context).colorScheme.surface),
                        ))
                  ],
                )
              ],
            ),
          );
        });
  }

  void _addComment(String comment) {
    _commentBloc.add(AddCommentEvent());
    _drawBloc.add(CommentUpdateEvent(comment));
    Navigator.pop(context);
  }

  void _deleteComment() {
    showDialog<void>(
        context: context,
        builder: (context) {
          return ConfirmAlert(
            title: 'Delete comment',
            onConfirm: () {
              _commentBloc.add(DeleteCommentEvent());
              _drawBloc.add(CommentUpdateEvent(null));
              widget._comment.clear();
            },
            confirmButtonLabel: 'Delete',
            message:
                'Do you want to delete the comment that you have written ?',
          );
        });
  }

  Widget _recordingBuilder(BuildContext context) =>
      BlocBuilder<RecordBloc, BlocState>(builder: (context, state) {
        String path;
        switch (state.runtimeType) {
          case LoadingState:
            {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            break;
          case PlayingRecordState:
            {
              return Tooltip(
                message: "Pause",
                child: IconButton(
                    icon: Icon(Icons.pause),
                    tooltip: "Pause",
                    onPressed: () {
                      path = (state as RecordState).recordPath;
                      _recordBloc.add(PauseRecordPlayingEvent());
                    }),
              );
            }
            break;
          case RecordingState:
            {
              return Tooltip(
                message: "Stop recording",
                child: IconButton(
                    icon: Icon(Icons.pause),
                    onPressed: () {
                      path = (state as RecordState).recordPath;
                      _recordBloc.add(StopRecordingEvent());
                    }),
              );
            }
            break;
          case StopRecordingState:
            {
              path = (state as RecordState).recordPath ??
                  _drawBloc.selectedPolygon.localRecordPath;
              if (!_drawBloc.selectedPolygon.recordSaved) {
                _drawBloc.add(RecordUpdateEvent(path));
              }
              return DropdownButton(
                hint: Icon(IReadIcons.microphone),
                items: [
                  DropdownMenuItem(
                      child: Center(child: Icon(Icons.play_arrow)),
                      value: 'play'),
                  DropdownMenuItem(
                    child: Center(child: Icon(IReadIcons.delete)),
                    value: 'delete',
                  ),
                ],
                elevation: 1,
                onChanged: _drawBloc.canInteract
                    ? (value) {
                        if (value == 'delete') {
                          return _deleteRecord(context, path);
                        } else if (value == 'play') {
                          _recordBloc.add(PlayRecordEvent(
                              _drawBloc.selectedPolygon.record, path));
                        }
                      }
                    : null,
              );
            }
            break;
        }

        return Tooltip(
          message: "Record",
          child: IconButton(
              icon: Icon(IReadIcons.microphone),
              onPressed: _drawBloc.canInteract
                  ? () {
                      _recordBloc.add(RecordEvent());
                    }
                  : null),
        );
      });

  void _deleteRecord(BuildContext context, String path) {
    showDialog(
        context: context,
        builder: (context) {
          return ConfirmAlert(
            title: 'Delete record',
            onConfirm: () {
              _drawBloc.add(PolygonRecordDeleteEvent());
              _recordBloc.add(DeleteRecordEvent(path));
            },
            message:
                'Do you want to delete the record that you have recorded ?',
            confirmButtonLabel: 'Delete',
          );
        });
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
      _drawBloc.closed = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget._comment.dispose();
    _recordBloc.dispose();
  }

  _deleteButton(BuildContext context, BlocState state) {
    if (state.runtimeType == PolygonDeletingState) {
      return Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Tooltip(
        message: "Delete the draw",
        child: IconButton(
            icon: Icon(IReadIcons.delete),
            onPressed: _drawBloc.canInteract
                ? () {
                    setState(() {
                      showDialog<void>(
                          context: context,
                          builder: (context) {
                            return ConfirmAlert(
                              title: 'Delete the polygon',
                              onConfirm: () {
                                _drawBloc.add(DeletePolygonEvent());
                              },
                              confirmButtonLabel: 'Delete',
                              message:
                                  'Do you want to delete the polygon that you have painted ?',
                            );
                          });
                    });
                  }
                : null),
      );
    }
  }

  _colorPickerButton() => Positioned(
        bottom: 24,
        right: 24,
        child: Tooltip(
          message: 'Pick a color',
          child: ElevatedButton(
            onPressed: () {
              _showColorPicker(context);
            },
            child: Container(
              color: _drawBloc.color,
              child: Center(
                child: Icon(Icons.palette_outlined),
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: _drawBloc.color, shape: CircleBorder(), elevation: 20),
          ),
        ),
      );

  _showColorPicker(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Pick a draw color'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: _drawBloc.color,
                onColorChanged: _drawBloc.changeColor,
              ),
            ),
          ));
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
        paintData = paint ??
            (Paint()
              ..style = PaintingStyle.fill
              ..strokeCap = StrokeCap.butt
              ..isAntiAlias = true
              ..color = Colors.black12.withOpacity(0.5)),
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
