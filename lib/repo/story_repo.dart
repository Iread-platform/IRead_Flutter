import 'dart:convert';

import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/repo/main_repo.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'package:iread_flutter/utils/exception.dart';

class StoryRepo extends MainRepo {
  static final StoryRepo _instance = StoryRepo._internal();

  final tagSearchEndPoint = "";

  factory StoryRepo() => _instance;
  StoryRepo._internal();

  Future<StoriesSectionModel> searchByTag(String tag) async {
    try {
      final jsonText = await apiService.request(
          requestType: RequestType.GET, endPoint: tagSearchEndPoint);
      final json = jsonDecode(jsonText);
      return StoriesSectionModel.fromJson(json);
    } on NetworkException {}
  }
}
