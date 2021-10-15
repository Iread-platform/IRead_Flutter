import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:iread_flutter/models/story_model.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'package:iread_flutter/utils/data.dart';
import 'package:iread_flutter/utils/exception.dart';

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

  Future<Data> fetchStoryPage(int id) async {
    try {
      final url = "Story/getStoryToListen/" + id.toString();
      final jsonText =
          await apiService.request(requestType: RequestType.GET, endPoint: url);
      final json = jsonDecode(jsonText);
      return Data.success(StoryModel.fromJson(json));
    } catch (e) {
      if (e is NetworkException) {
        return Data.fail(e.message);
      } else if (e is SocketException) {
        return Data.fail("No Enternet");
      } else if (e is TimeoutException) {
        return Data.fail("Time out Exception");
      } else {
        return Data.fail("something is not working");
      }
    }
  }
}
