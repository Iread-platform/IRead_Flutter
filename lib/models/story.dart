import 'package:flutter/material.dart';

import 'model.dart';

class Story extends Model {
  String _title;
  double _progress;
  Color _color;
  int _flippedPages;
  double _readingTime;

  Story({@required title, @required color, progress, flippedPages, readingTime})
      : _title = title,
        _color = color,
        _flippedPages = flippedPages,
        _readingTime = readingTime,
        _progress = progress;

  get title => _title;
  get progress => _progress;
  get color => _color;
  get flippedPages => _flippedPages;
  get readingTime => _readingTime;
}
