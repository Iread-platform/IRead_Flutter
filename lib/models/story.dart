import 'package:flutter/material.dart';

import 'model.dart';

class Story extends Model {
  String _title;
  String _imageUrl;
  double _progress;
  Color _color;
  int _flippedPages;
  double _readingTime;

  Story(
      {@required title,
      @required color,
      imageUrl,
      progress,
      flippedPages,
      readingTime,
      id})
      : _title = title,
        _color = color,
        _imageUrl = imageUrl,
        _flippedPages = flippedPages,
        _readingTime = readingTime,
        _progress = progress,
        super(id: id);

  get title => _title;
  get progress => _progress;
  get color => _color;
  get imageUrl => _imageUrl;
  get flippedPages => _flippedPages;
  get readingTime => _readingTime;
}
