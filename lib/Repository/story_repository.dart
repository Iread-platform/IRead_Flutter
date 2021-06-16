import 'dart:async';

import 'package:iread_flutter/models/Data.dart';
import 'package:iread_flutter/models/story_page_model.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class StoryRepository {
  ApiService apiService;
  StoryRepository() {
    apiService = new ApiService();
  }
  /*
  request : 
    storyid , page 
  response: 
    audio , text , image, 
  */

  Future<Data<StoryPage>> fetchStoryPage() async {
    // try {
    // final responseText = await apiService.request(
    //     requestType: RequestType.GET, endPoint: "", parameter: "");
    Map<String, dynamic> jsonResponse = json
        .decode(await rootBundle.loadString('lib/Repository/dummyData.json'));
    StoryPage data = StoryPage.fromJson(jsonResponse);
    return Data.succeed(data: data);
    // } on NetworkException {
    //   return Data.faild(message: "NetworkException");
    // } on TimeoutException {
    //   return Data.faild(message: "TimeoutException");
    // } catch (e) {
    //   return Data.faild(message: "An error has occurred");
    // }
  }
}
