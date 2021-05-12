import 'package:iread_flutter/models/story.dart';

import 'model.dart';

class StoriesSectionModel extends Model {
  String title;
  List<Story> stories;

  StoriesSectionModel(this.title, this.stories);
}
