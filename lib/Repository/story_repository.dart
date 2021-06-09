import 'dart:async';

import 'package:iread_flutter/bloc/Data.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'dart:convert';

import 'package:iread_flutter/utils/exception.dart';

class StoryRepository {
  ApiService apiService;
  String audioURL;
  String story;
  StoryRepository() {
    apiService = new ApiService();
  }
  Future<Data<String>> getAudioURL() async {
    try {
      final responseText = await apiService.request(
          requestType: RequestType.GET, endPoint: "", parameter: "");

      final jsonResponse = json.decode(responseText);
    } on NetworkException catch (e) {
      return Data.faild(message: "An error has occurred");
    } on TimeoutException catch (e) {} catch (e) {
      return Data.faild(message: "An error has occurred");
    }
  }

  Future<Data<String>> getStory() async {
    try {
      final responseText = await apiService.request(
          requestType: RequestType.GET, endPoint: "", parameter: "");

      final jsonResponse = json.decode(responseText);
    } on NetworkException catch (e) {
      return Data.faild(message: "An error has occurred");
    } on TimeoutException catch (e) {} catch (e) {
      return Data.faild(message: "An error has occurred");
    }
  }
}
