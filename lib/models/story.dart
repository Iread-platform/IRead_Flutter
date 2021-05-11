import 'package:flutter/material.dart';

import 'model.dart';

class Story extends Model {
  String _title;
  double _progress;
  Color _color;
  int _flippedPages;
  double _readingTime;

  get title => _title;
  get progress => _progress;
  get color => _color;
  get flippedPages => _flippedPages;
  get readingTime => _readingTime;
}
