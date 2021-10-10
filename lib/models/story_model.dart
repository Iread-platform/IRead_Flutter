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
  String imageURL;

  List<Word> words;
  double startPageTime = 0;
  double endPageTime = 0;
  Pages({this.pageId, this.content, this.words});

  Pages.fromJson(Map<String, dynamic> json) {
    pageId = json['pageId'];
    content = json['content'];
    imageURL = json["image"]["downloadUrl"];
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
}

class Comment {
  int commentId;
  String word;
  String classOFWord;
  String definitionOfWord;
  String exampleOfWord;
  int wordIndex;

  Comment(
      {this.commentId,
      this.word,
      this.classOFWord,
      this.definitionOfWord,
      this.exampleOfWord,
      this.wordIndex});

  Comment.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    word = json['word'];
    wordIndex = json['wordIndex'];

    classOFWord = json['classOFWord'];
    definitionOfWord = json['definitionOfWord'];
    exampleOfWord = json['exampleOfWord'];
  }
}

class Word {
  String id;
  String content;
  String inputStart;
  String inputEnd;
  String suffix;
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
}
