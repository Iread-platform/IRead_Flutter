import 'package:iread_flutter/models/story.dart';

import 'model.dart';

class StoriesSection extends Model {
  String title;
  List<Story> stories;

  StoriesSection(this.title, this.stories);
}
