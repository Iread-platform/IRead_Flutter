import 'package:iread_flutter/models/story.dart';

import 'model.dart';

class StoriesSectionModel extends Model {
  String title;
  List<Story> stories;

  StoriesSectionModel(this.title, this.stories);

  StoriesSectionModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    final stories = json['stories'];

    this.stories = [];
    for (int i = 0; i < stories.length; i++) {
      this.stories.add(Story.fromJson(stories[i]));
    }
  }
}
