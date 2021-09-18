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
  final String deletePolygonEndpoint = 'drawing/@id/delete';
  final String fetchPolygonById = 'drawing/@id/get';

  Future<Data<Polygon>> savePolygon(Polygon polygon, int storyId) async {
    try {
      final json = _constructPolygonData(polygon, storyId);
      final url = '$baseEndpoint/$savePolygonEndpoint';
      final response = await _apiService.request(
          requestType: RequestType.POST, endPoint: url, parameter: json);
      final jsonRes = jsonDecode(response);
      return Data.success(Polygon.fromJson(jsonRes));
    } catch (e) {
      return Data.handleException(e);
    }
  }

  Future<Data<bool>> updatePolygon(Polygon polygon, int storyId) async {
    try {
      final json = _constructPolygonData(polygon, storyId);
      final url =
          '$baseEndpoint/${updatePolygonEndpoint.replaceAll('@id', polygon.id.toString())}';
      await _apiService.request(
          requestType: RequestType.PUT, endPoint: url, parameter: json);

      return Data.success(true);
    } catch (e) {
      return Data.handleException(e);
    }
  }

  Future<Data<bool>> deletePolygon(Polygon polygon) async {
    try {
      final url =
          '$baseEndpoint/${deletePolygonEndpoint.replaceAll('@id', polygon.id.toString())}';
      await _apiService.request(requestType: RequestType.DELETE, endPoint: url);

      return Data.success(true);
    } catch (e) {
      return Data.handleException<bool>(e);
    }
  }

  Future<Data<Polygon>> fetchPolygon(int id) async {
    try {
      final url =
          '$baseEndpoint/${fetchPolygonById.replaceAll('@id', id.toString())}';
      final response = await _apiService.request(
          requestType: RequestType.GET, endPoint: url);
      final json = jsonDecode(response);
      return Data.success(Polygon.fromJson(json));
    } catch (e) {
      return Data.handleException(e);
    }
  }

  Map<String, dynamic> _constructPolygonData(Polygon polygon, int storyId) {
    // Dummy studentId
    String studentId = 'a6ffd485-86fc-4901-99b1-fa66dd948ac2';
    int pageId = 1;
    Interaction interaction = Interaction(studentId, pageId, storyId);

    final json = {
      "points": jsonEncode(polygon.pointsToJson()),
      "interaction": interaction.json,
      "comment": polygon.comment,
      "maxX": polygon.maxX.round(),
      "minX": polygon.minX.round(),
      "maxY": polygon.maxY.round(),
      "minY": polygon.minY.round(),
    };

    if (polygon.audioId != null) {
      json['audioId'] = polygon.audioId;
    }

    return json;
  }

  Future addHighLightWord(Map map) async {
    final url = "http://217.182.250.236:5016/api/Interaction/HighLight/add";
    final jsonText = await _apiService.request(
        requestType: RequestType.POST, endPoint: url, parameter: map);
    final json = jsonDecode(jsonText);
    print(json);
  }
}
