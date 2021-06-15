import 'package:flutter/material.dart';

import 'model.dart';

class Story extends Model {
  String _title;
  String _imageUrl;
  DateTime _releaseDate;
  String _desciption;
  int _storyLevel;
  String _writer;
  double _progress;
  Color _color;
  int _flippedPages;
  double _readingTime;
  List<String> _keyWords;
  double _rating;

  Story(
      {@required String title,
      @required color,
      DateTime releaseDate,
      String description,
      int storyLevel,
      String writer,
      String imageUrl,
      double progress,
      int flippedPages,
      double readingTime,
      List<String> keyWords,
      double rating,
      int id})
      : _title = title,
        _color = color,
        _releaseDate = releaseDate,
        _desciption = description,
        _storyLevel = storyLevel,
        _writer = writer,
        _imageUrl = imageUrl,
        _flippedPages = flippedPages,
        _readingTime = readingTime,
        _progress = progress,
        _keyWords = keyWords,
        _rating = rating,
        super(id: id);

  Story.fromJson(Map<String, dynamic> json) : super(id: json['storyId']) {
    _title = json['title'];
    _releaseDate = DateTime.parse(json['releaseDate']);
    _desciption = json['description'];
    _storyLevel = json['storyLevel'];
    _writer = json['writer'];
    _rating = json['rating'];
    _color = Color(int.parse('0x' + json['color'], radix: 16));
    _imageUrl = json['imageUrl'];
    _flippedPages = json['flippedPages'];
    _readingTime = json['readingTime'];
    _progress = json['progress'];

    _keyWords = [];
    for (int i = 0; i < json['keyWords'].length; i++) {
      _keyWords.add(json['keyWords'][i]);
    }
  }

  get title => _title;
  get progress => _progress;
  get color => _color;
  get imageUrl => _imageUrl;
  get flippedPages => _flippedPages;
  get readingTime => _readingTime;
}
