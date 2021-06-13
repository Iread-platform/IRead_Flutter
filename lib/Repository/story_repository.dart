import 'dart:async';

import 'package:iread_flutter/models/Data.dart';
import 'package:iread_flutter/models/word.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'dart:convert';

import 'package:iread_flutter/utils/exception.dart';

class StoryRepository {
  ApiService apiService;
  String audioURL;
  String story;
  String dummyAudioURL =
      "https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_5MG.mp3";
  String dummyData = '''[
    {"word": "while", "start": 0, "timestamp": 0},
    {"word": "drawing", "start": 0, "timestamp": 500},
    {"word": "in", "start": 0, "timestamp": 800},
    {"word": "class", "start": 0, "timestamp": 1200},
    {"word": "at", "start": 0, "timestamp": 1300},
    {"word": "Stagwood", "start": 0, "timestamp": 1800},
    {"word": "School", "start": 0, "timestamp": 1900},
    {"word": "old", "start": 0, "timestamp": 2500},
    {"word": "Cal", "start": 0, "timestamp": 2800},
    {"word": "sees", "start": 0, "timestamp": 3000},
    {"word": "a", "start": 0, "timestamp": 3200},
    {"word": "frog", "start": 0, "timestamp": 3400},
    {"word": "staring", "start": 0, "timestamp": 3700}
  ]''';
  StoryRepository() {
    apiService = new ApiService();
  }
  /*
  request : 
    storyid , page 
  response: 
    audio , text , image, 
  */

  Future<Data<String>> getAudioURL() async {
    try {
      // final responseText = await apiService.request(
      //     requestType: RequestType.GET, endPoint: "", parameter: "");

      // final jsonResponse = json.decode(dummyData);
      return Data.succeed(data: dummyAudioURL);
    } on NetworkException catch (e) {
      return Data.faild(message: "An error has occurred");
    } on TimeoutException catch (e) {} catch (e) {
      return Data.faild(message: "An error has occurred");
    }
  }

  Future<Data<List<Word>>> getStory() async {
    // try {
    // final responseText = await apiService.request(
    //     requestType: RequestType.GET, endPoint: "", parameter: "");

    List jsonResponse = json.decode(dummyData);
    print(jsonResponse);
    List<Word> data = jsonResponse.map((word) => Word.fromJson(word)).toList();
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
