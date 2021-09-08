import 'dart:async';

import 'package:iread_flutter/models/Data.dart';
import 'package:iread_flutter/models/story_model.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'dart:convert';

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
  /*
   =======interAction========
   {
    "commentType": "string",
    "value": "string",
    "interaction": {
      "storyId": 0,
      "studentId": "string",
      "pageId": 0
    },
    "wordTimesTamp": "string",
    "word": "string"
  }
  */

  Future<Data<StoryModel>> fetchStoryPage(int id) async {
    try {
      final url = "iread/Story/getStoryToListen/"+id.toString();
      final jsonText =
          await apiService.request(requestType: RequestType.GET, endPoint: url);
      final json = jsonDecode(jsonText);
      Data<StoryModel> data = Data.succeed(data: StoryModel.fromJson(json));
      return data;
    } catch (e) {
      return Data.faild(message: e.toString());
    }
  }
}
