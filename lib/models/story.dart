import 'package:flutter/material.dart';

import 'model.dart';

class Story extends Model {
  String _title;
  String _imageUrl;
  String _description;
  double _progress;
  Color _color;
  int _flippedPages;
  double _readingTime;

  Story(
      {@required title,
      @required color,
      @required description,
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
        _description = description,
        super(id: id);

  get title => _title;
  get description => _description;
  get progress => _progress;
  get color => _color;
  get imageUrl => _imageUrl;
  get flippedPages => _flippedPages;
  get readingTime => _readingTime;
}
