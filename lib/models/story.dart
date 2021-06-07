import 'package:flutter/material.dart';

import 'model.dart';

class Story extends Model {
  String _title;
  String _imageUrl;
  String _description;
  String _author;
  int _pages;
  double _progress;
  Color _color;
  int _flippedPages;
  double _readingTime;
  List<String> _tags;

  Story(
      {@required title,
      @required color,
      @required description,
      tags,
      author,
      pages,
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
        _author = author,
        _pages = pages,
        _tags = tags,
        super(id: id);

  get title => _title;
  get description => _description;
  get author => _author;
  get pages => _pages;
  get progress => _progress;
  get color => _color;
  get imageUrl => _imageUrl;
  get flippedPages => _flippedPages;
  get readingTime => _readingTime;
  get tags => _tags;
}
