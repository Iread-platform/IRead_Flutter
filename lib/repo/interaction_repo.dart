import 'dart:convert';

import 'package:iread_flutter/models/draw/polygon.dart';
import 'package:iread_flutter/models/interaction/interaction.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'package:iread_flutter/utils/data.dart';

class InteractionRepo {
  final ApiService _apiService = ApiService();

  static InteractionRepo _instance = InteractionRepo._internal();
  factory InteractionRepo() => _instance;
  InteractionRepo._internal();

  final String baseEndpoint = 'interaction';
  final String savePolygonEndpoint = 'drawing/add';

  Future<Data> savePolygon(Polygon polygon, int storyId) async {
    // Dummy studentId
    String studentId = 'a6ffd485-86fc-4901-99b1-fa66dd948ac2';
    Interaction interaction = Interaction(studentId, 1, storyId);

    Map<String, dynamic> json = {
      "points": jsonEncode(polygon.pointsToJson()),
      "interaction": interaction.json,
      "comment": polygon.comment
    };

    try {
      final url = '$baseEndpoint/$savePolygonEndpoint';
      final response = await _apiService.request(
          requestType: RequestType.POST, endPoint: url, parameter: json);
      final jsonRes = jsonDecode(response);
      print('Json response is $jsonRes');

      return Data.success(jsonRes);
    } catch (e) {
      Data.handleException(e);
    }
  }
}
