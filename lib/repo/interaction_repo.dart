import 'dart:convert';

import 'package:iread_flutter/models/draw/polygon.dart';
import 'package:iread_flutter/models/interaction/interaction.dart';
import 'package:iread_flutter/services/api_service.dart';

class InteractionRepo {
  final ApiService _apiService = ApiService();

  static InteractionRepo _instance = InteractionRepo._internal();
  factory InteractionRepo() => _instance;
  InteractionRepo._internal();

  final String baseEndpoint = 'interaction';
  final String savePolygonEndpoint = 'polygon/add';

  Future<Stream> savePolygon(Polygon polygon, int storyId) async {
    String studentId;
    Interaction interaction = Interaction(studentId, 0, storyId);

    Map<String, dynamic> json = {
      "points": jsonEncode(polygon.pointsToJson()),
      "interaction": interaction.json,
      "audioId": 0,
      "comment": polygon.comment
    };
  }
}
