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
  final String savePolygonEndpoint = 'polygon/add';

  Future<Data> savePolygon(Polygon polygon, int storyId) async {
    String studentId;
    Interaction interaction = Interaction(studentId, 0, storyId);

    Map<String, dynamic> json = {
      "points": jsonEncode(polygon.pointsToJson()),
      "interaction": interaction.json,
      "audioId": 0,
      "comment": polygon.comment
    };

    try {
      final response = await _apiService.request(
          requestType: RequestType.POST,
          endPoint: '$baseEndpoint/$savePolygonEndpoint',
          parameter: json);
      final jsonRes = jsonDecode(response);
      print('Json response is $jsonRes');

      return Data.success(jsonRes);
    } catch (e) {
      Data.handleException(e);
    }
  }
}
