import 'dart:convert' as JSON;

class StoryModel {
  Audio audio;
  int pagesCount;
  List<Pages> pages;

  StoryModel({this.audio, this.pagesCount, this.pages});

  StoryModel.fromJson(Map<String, dynamic> json) {
    audio = json['audio'] != null ? new Audio.fromJson(json['audio']) : null;
    pagesCount = json['pagesCount'];
    if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages.add(new Pages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.audio != null) {
      data['audio'] = this.audio.toJson();
    }
    data['pagesCount'] = this.pagesCount;
    if (this.pages != null) {
      data['pages'] = this.pages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Audio {
  int id;
  String name;
  String downloadUrl;
  String type;
  String extension;
  int size;
  String uploadDate;

  Audio(
      {this.id,
      this.name,
      this.downloadUrl,
      this.type,
      this.extension,
      this.size,
      this.uploadDate});

  Audio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    downloadUrl = json['downloadUrl'];
    type = json['type'];
    extension = json['extension'];
    size = json['size'];
    uploadDate = json['uploadDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['downloadUrl'] = this.downloadUrl;
    data['type'] = this.type;
    data['extension'] = this.extension;
    data['size'] = this.size;
    data['uploadDate'] = this.uploadDate;
    return data;
  }
}

class Pages {
  int pageId;
  String content;
  List<Word> words;
  double startPageTime = 0;
  double endPageTime = 0;
  Pages({this.pageId, this.content, this.words});

  Pages.fromJson(Map<String, dynamic> json) {
    pageId = json['pageId'];
    content = json['content'];
    var jsonWord = JSON.jsonDecode(json['words']);
    if (jsonWord != null) {
      words = <Word>[];
      jsonWord.forEach((v) {
        words.add(new Word.fromJson(v));
      });
      startPageTime = words[0].timeStart;
      endPageTime = words[words.length - 1].timeEnd;
    }
    // words = json['words'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageId'] = this.pageId;
    data['content'] = this.content;
    data['words'] = this.words;
    return data;
  }
}

class Word {
  String id;
  String content;
  String inputStart;
  String inputEnd;
  double regionStart;
  double regionEnd;
  bool elementError;
  double timeStart;
  double timeEnd;

  int startIndex;
  bool newLine = false;
  double scrollHight = 0;

  Word(
      {this.id,
      this.content,
      this.inputStart,
      this.inputEnd,
      this.regionStart,
      this.regionEnd,
      this.elementError,
      this.timeStart,
      this.timeEnd});

  Word.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    content = json['Content'];
    inputStart = json['InputStart'];
    inputEnd = json['InputEnd'];
    regionStart = json['RegionStart'];
    regionEnd = json['RegionEnd'];
    elementError = json['ElementError'];
    timeStart = json['TimeStart'];
    timeEnd = json['TimeEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Content'] = this.content;
    data['InputStart'] = this.inputStart;
    data['InputEnd'] = this.inputEnd;
    data['RegionStart'] = this.regionStart;
    data['RegionEnd'] = this.regionEnd;
    data['ElementError'] = this.elementError;
    data['TimeStart'] = this.timeStart;
    data['TimeEnd'] = this.timeEnd;
    return data;
  }
}
