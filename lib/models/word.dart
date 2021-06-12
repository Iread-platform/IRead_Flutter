class Word {
  String word;
  int start;
  int timestamp;

  Word({this.word, this.start, this.timestamp});

  Word.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    start = json['start'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    data['start'] = this.start;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
