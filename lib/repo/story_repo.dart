import 'dart:convert';

import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/repo/main_repo.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'package:iread_flutter/utils/data.dart';

class StoryRepo extends MainRepo {
  static final StoryRepo _instance = StoryRepo._internal();

  final baseStoryPath = "story";
  final searchByTagEndPoint = "Story/GetStoriesByTagTitle";
  final getStoryByIdEndpoint = "story/get";

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
        "rating": 4.23,
        "color": 'FF0000FF',
        "imageUrl": 'https://picsum.photos/200/300'
      },
      {
        "storyId": 1,
        "title": "Story title",
        "releaseDate": DateTime.now().toString(),
        "description": "Story description",
        "storyLevel": 0,
        "keyWords": ["Learn", "Easy"],
        "rating": 4.23,
        "color": 'FF0000FF',
        "imageUrl": 'https://picsum.photos/200/300'
      },
      {
        "storyId": 1,
        "title": "Story title",
        "releaseDate": DateTime.now().toString(),
        "description": "Story description",
        "storyLevel": 0,
        "keyWords": ["Learn", "Easy"],
        "rating": 4.23,
        "color": 'FF0000FF',
        "imageUrl": 'https://picsum.photos/200/300'
      },
      {
        "storyId": 1,
        "title": "Story title",
        "releaseDate": DateTime.now().toString(),
        "description": "Story description",
        "storyLevel": 0,
        "keyWords": ["Learn", "Easy"],
        "rating": 4.23,
        "color": 'FF0000FF',
        "imageUrl": 'https://picsum.photos/200/300'
      },
      {
        "storyId": 1,
        "title": "Story title",
        "releaseDate": DateTime.now().toString(),
        "description": "Story description",
        "storyLevel": 0,
        "keyWords": ["Learn", "Easy"],
        "rating": 4.23,
        "color": 'FF0000FF',
        "imageUrl": 'https://picsum.photos/200/300'
      },
      {
        "storyId": 1,
        "title": "Story title",
        "releaseDate": DateTime.now().toString(),
        "description": "Story description",
        "storyLevel": 0,
        "keyWords": ["Learn", "Easy"],
        "rating": 4.23,
        "color": 'FF0000FF',
        "imageUrl": 'https://picsum.photos/200/300'
      },
      {
        "storyId": 1,
        "title": "Story title",
        "releaseDate": DateTime.now().toString(),
        "description": "Story description",
        "storyLevel": 0,
        "keyWords": ["Learn", "Easy"],
        "rating": 4.23,
        "color": 'FF0000FF',
        "imageUrl": 'https://picsum.photos/200/300'
      }
    ]
  };

  Future<Data<StoriesSectionModel>> searchByTag(String tag) async {
    try {
      final url = '$searchByTagEndPoint/$tag';
      final jsonText =
          await apiService.request(requestType: RequestType.GET, endPoint: url);
      final stories = jsonDecode(jsonText);
      // Construct json data to consume.
      var json = {};
      json['stories'] = stories;
      json['title'] = tag;

      return Data.success(StoriesSectionModel.fromJson(json));
    } catch (e) {
      return Data.handleException<StoriesSectionModel>(e);
    }
  }

  Future<Data<Story>> fetchStoryById(int id) async {
    try {
      final url = "$getStoryByIdEndpoint/$id";
      final jsonText =
          await apiService.request(requestType: RequestType.GET, endPoint: url);
      final json = jsonDecode(jsonText);

      return Data.success(Story.fromJson(json));
    } catch (e) {
      return Data.handleException(e);
    }
  }
}
