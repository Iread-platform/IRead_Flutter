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
  List<HighLights> highLights;
  List<Comment> comments;

  List<Word> words;
  double startPageTime = 0;
  double endPageTime = 0;
  Pages({this.pageId, this.content, this.words});

  Pages.fromJson(Map<String, dynamic> json) {
    pageId = json['pageId'];
    content = json['content'];

    var jsonhighLights = json['highLights'];
    if (jsonhighLights != null) {
      highLights = <HighLights>[];
      jsonhighLights.forEach((v) {
        highLights.add(new HighLights.fromJson(v));
      });
    }
    var jsoncomments = json['comments'];
    if (jsoncomments != null) {
      comments = <Comment>[];
      jsoncomments.forEach((v) {
        comments.add(new Comment.fromJson(v));
      });
    }
    var jsonWord = JSON.jsonDecode(json['words']);
    if (jsonWord != null) {
      words = <Word>[];
      jsonWord.forEach((v) {
        words.add(new Word.fromJson(v));
      });
      startPageTime = words[0].timeStart;
      endPageTime = words[words.length - 1].timeEnd;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageId'] = this.pageId;
    data['content'] = this.content;
    data['words'] = this.words;
    return data;
  }
}

class HighLights {
  int highLightId;
  int firstWordIndex;
  int endWordIndex;
  String firstWord;
  String endWord;

  HighLights(
      {this.highLightId,
      this.firstWordIndex,
      this.endWordIndex,
      this.firstWord,
      this.endWord});

  HighLights.fromJson(Map<String, dynamic> json) {
    highLightId = json['highLightId'];
    firstWordIndex = json['firstWordIndex'];
    endWordIndex = json['endWordIndex'];
    firstWord = json['firstWord'];
    endWord = json['endWord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['highLightId'] = this.highLightId;
    data['firstWordIndex'] = this.firstWordIndex;
    data['endWordIndex'] = this.endWordIndex;
    data['firstWord'] = this.firstWord;
    data['endWord'] = this.endWord;
    return data;
  }
}

class Comment {
  int commentId;
  String word;
  String classOFWord;
  String definitionOfWord;
  String exampleOfWord;

  Comment(
      {this.commentId,
      this.word,
      this.classOFWord,
      this.definitionOfWord,
      this.exampleOfWord});

  Comment.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    word = json['word'];
    classOFWord = json['classOFWord'];
    definitionOfWord = json['definitionOfWord'];
    exampleOfWord = json['exampleOfWord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentId'] = this.commentId;
    data['word'] = this.word;
    data['classOFWord'] = this.classOFWord;
    data['definitionOfWord'] = this.definitionOfWord;
    data['exampleOfWord'] = this.exampleOfWord;
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
  bool isHighLighted = false;
  int highLightID = -1;
  bool isComment = false;
  int commentId = -1;
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
