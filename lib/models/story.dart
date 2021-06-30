import 'package:flutter/material.dart';

import 'model.dart';

class Story extends Model {
  String _title;
  String _imageUrl;
  DateTime _releaseDate;
  int _storyLevel;
  String _writer;
  String _description;
  int _pages;
  double _progress;
  Color _color;
  int _flippedPages;
  double _readingTime;
  List<String> _keyWords;
  double _rating;
  List<String> _tags;

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
      List<String> tags,
      double rating,
      int pages,
      int id})
      : _title = title,
        _color = color,
        _releaseDate = releaseDate,
        _description = description,
        _storyLevel = storyLevel,
        _writer = writer,
        _imageUrl = imageUrl,
        _flippedPages = flippedPages,
        _readingTime = readingTime,
        _progress = progress,
        _keyWords = keyWords,
        _rating = rating,
        _pages = pages,
        _tags = tags,
        super(id: id);

  Story.fromJson(Map<String, dynamic> json) : super(id: json['storyId']) {
    _title = json['title'];
    _releaseDate = DateTime.parse(json['releaseDate']);
    _description = json['description'];
    _storyLevel = json['storyLevel'];
    _writer = json['writer'];
    _rating = json['rating'].toDouble();
    _color = json['color'] != null
        ? Color(int.parse(json['color'], radix: 16))
        : Colors.lightGreenAccent;
    _imageUrl = json['imageUrl'] ??
        'https://images.unsplash.com/photo-1553060146-71667aa3f223?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
    _flippedPages = json['flippedPages'];
    _readingTime = json['readingTime'];
    _progress = json['progress'];
    _pages = json['pages'];

    if (json['keyWords'] != null) {
      _keyWords = [];
      for (int i = 0; i < json['keyWords'].length; i++) {
        _keyWords.add(json['keyWords'][i]);
      }
    }

    if (json['tags'] != null) {
      _tags = [];
      for (int i = 0; i < json['tags'].length; i++) {
        _tags.add(json['tags'][i]);
      }
    }

    // TODO remove dummy tags
    _tags = [];
    _tags.add('story');
    _tags.add('action');
    _tags.add('nature');
  }

  get title => _title;

  get description => _description;

  get pages => _pages;

  get progress => _progress;

  get color => _color;

  get imageUrl => _imageUrl;

  get flippedPages => _flippedPages;

  get readingTime => _readingTime;

  get releaseDate => _releaseDate;

  get level => _storyLevel;

  get writer => _writer;

  get rating => _rating;

  get tags => _tags;
}
