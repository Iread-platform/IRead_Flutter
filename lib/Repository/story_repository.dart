import 'dart:async';

import 'package:iread_flutter/models/Data.dart';
import 'package:iread_flutter/models/story_page_model.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:iread_flutter/utils/exception.dart';

class StoryRepository {
  ApiService apiService;
  String audioURL;
  String story;
  String dummyAudioURL =
      "https://cdn.sndup.net/7bb6/Martin+Luther+King+Jr+I+Have+a+Dream+Speechllll.mp3?token=Mh5p9nuyWO_nszddLCBzOhM_kf-nq8Gnys8GP_NFr2A&token_path=%2F7bb6%2F&expires=1623767494";

  StoryRepository() {
    apiService = new ApiService();
  }
  /*
  request : 
    storyid , page 
  response: 
    audio , text , image, 
  */

  // Future<Data<String>> getAudioURL() async {
  //   try {
  //     // final responseText = await apiService.request(
  //     //     requestType: RequestType.GET, endPoint: "", parameter: "");

  //     // final jsonResponse = json.decode(dummyData);
  //     return Data.succeed(data: dummyAudioURL);
  //   } on NetworkException catch (e) {
  //     return Data.faild(message: "An error has occurred");
  //   } on TimeoutException catch (e) {} catch (e) {
  //     return Data.faild(message: "An error has occurred");
  //   }
  // }

  Future<Data<StoryPage>> fetchStoryPage() async {
    // try {
    // final responseText = await apiService.request(
    //     requestType: RequestType.GET, endPoint: "", parameter: "");
    Map<String, dynamic> jsonResponse = json
        .decode(await rootBundle.loadString('lib/Repository/dummyData.json'));
    StoryPage data = StoryPage.fromJson(jsonResponse);
    print(data.story);
    print(data.words.length);
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
