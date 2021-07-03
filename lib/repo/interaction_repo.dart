import 'package:iread_flutter/repo/main_repo.dart';
import 'package:iread_flutter/utils/data.dart';

class InteractionRepo extends MainRepo {
  static InteractionRepo _instance = InteractionRepo._internal();
  factory InteractionRepo() => _instance;
  InteractionRepo._internal();

  final String baseEndpoint = 'interaction';
  final String savePolygonEndpoint = 'polygon/add';

  Data savePolygon() {
    return Data.success(1);
  }
}
