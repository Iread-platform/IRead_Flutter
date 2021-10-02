// class StoryPage {
//   int pageNumber;
//   int pageCount;
//   String story = "";
//   String audioURL;
//   List<Words> words = [];

//   StoryPage(
//       {this.pageNumber, this.pageCount, this.story, this.audioURL, this.words});

//   StoryPage.fromJson(Map<String, dynamic> json) {
//     pageNumber = json['pageNumber'];
//     pageCount = json['pageCount'];
//     story = json['story'];
//     audioURL = json['audioURL'];
//     if (json['words'] != null) {
//       json['words'].forEach((v) {
//         print("word");
//         words.add(new Words.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['pageNumber'] = this.pageNumber;
//     data['pageCount'] = this.pageCount;
//     data['story'] = this.story;
//     data['audioURL'] = this.audioURL;
//     if (this.words != null) {
//       data['words'] = this.words.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Words {
//   String word;
//   int startIndex;
//   double time;
//   bool newLine = false;
//   double scrollHight = 0;

//   Words({this.word, this.startIndex, this.time});

//   Words.fromJson(Map<String, dynamic> json) {
//     word = json['word'];
//     startIndex = json['startIndex'];
//     time = json['time'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['word'] = this.word;
//     data['startIndex'] = this.startIndex;
//     data['time'] = this.time;
//     return data;
//   }
// }
