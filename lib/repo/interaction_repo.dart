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
  final String updatePolygonEndpoint = 'drawing/@id/update';

  Future<Data<Polygon>> savePolygon(Polygon polygon, int storyId) async {
    try {
      final json = _constructPolygonData(polygon, storyId);
      final url = '$baseEndpoint/$savePolygonEndpoint';
      final response = await _apiService.request(
          requestType: RequestType.POST, endPoint: url, parameter: json);
      final jsonRes = jsonDecode(response);
      return Data.success(Polygon.fromJson(jsonRes));
    } catch (e) {
      Data.handleException(e);
    }
  }

  Future<Data<bool>> updatePolygon(Polygon polygon, int storyId) async {
    try {
      final json = _constructPolygonData(polygon, storyId);
      final url =
          '$baseEndpoint/${updatePolygonEndpoint.replaceAll('@id', polygon.id.toString())}';
      final response = await _apiService.request(
          requestType: RequestType.PUT, endPoint: url, parameter: json);
      final jsonRes = jsonDecode(response);

      return Data.success(true);
    } catch (e) {
      Data.handleException(e);
    }
  }

  Map<String, dynamic> _constructPolygonData(Polygon polygon, int storyId) {
    // Dummy studentId
    String studentId = 'a6ffd485-86fc-4901-99b1-fa66dd948ac2';
    Interaction interaction = Interaction(studentId, 1, storyId);

    final json = {
      "points": jsonEncode(polygon.pointsToJson()),
      "interaction": interaction.json,
      "comment": polygon.comment,
    };

    if (polygon.audioId != null) {
      json['audioId'] = polygon.audioId;
    }

    return json;
  }
}
