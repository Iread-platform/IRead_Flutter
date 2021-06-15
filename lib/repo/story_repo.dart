import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/repo/main_repo.dart';
import 'package:iread_flutter/utils/exception.dart';

class StoryRepo extends MainRepo {
  static final StoryRepo _instance = StoryRepo._internal();

  final tagSearchEndPoint = "";

  factory StoryRepo() => _instance;
  StoryRepo._internal();

  final storySectionJson = {
    "title": "Title",
    "stories": [
      {
        "storyId": 1,
        "title": "Story title",
        "releaseDate": DateTime.now().toString(),
        "description": "Story description",
        "storyLevel": 0,
        "keyWords": ["Learn", "Easy"],
        "rating": 4.23
      },
      {
        "storyId": 1,
        "title": "Story title",
        "releaseDate": DateTime.now().toString(),
        "description": "Story description",
        "storyLevel": 0,
        "keyWords": ["Learn", "Easy"],
        "rating": 4.23
      },
      {
        "storyId": 1,
        "title": "Story title",
        "releaseDate": DateTime.now().toString(),
        "description": "Story description",
        "storyLevel": 0,
        "keyWords": ["Learn", "Easy"],
        "rating": 4.23
      },
      {
        "storyId": 1,
        "title": "Story title",
        "releaseDate": DateTime.now().toString(),
        "description": "Story description",
        "storyLevel": 0,
        "keyWords": ["Learn", "Easy"],
        "rating": 4.23
      },
      {
        "storyId": 1,
        "title": "Story title",
        "releaseDate": DateTime.now().toString(),
        "description": "Story description",
        "storyLevel": 0,
        "keyWords": ["Learn", "Easy"],
        "rating": 4.23
      },
      {
        "storyId": 1,
        "title": "Story title",
        "releaseDate": DateTime.now().toString(),
        "description": "Story description",
        "storyLevel": 0,
        "keyWords": ["Learn", "Easy"],
        "rating": 4.23
      },
      {
        "storyId": 1,
        "title": "Story title",
        "releaseDate": DateTime.now().toString(),
        "description": "Story description",
        "storyLevel": 0,
        "keyWords": ["Learn", "Easy"],
        "rating": 4.23
      }
    ]
  };

  Future<StoriesSectionModel> searchByTag(String tag) async {
    try {
      /*final jsonText = await apiService.request(
          requestType: RequestType.GET, endPoint: tagSearchEndPoint);
      final json = jsonDecode(jsonText);*/
      // TODO get real data
      return StoriesSectionModel.fromJson(storySectionJson);
    } on NetworkException {}
  }
}
