import 'package:iread_flutter/repo/main_repo.dart';

class InteractionRepo extends MainRepo {
  static InteractionRepo _instance = InteractionRepo._internal();
  factory InteractionRepo() => _instance;
  InteractionRepo._internal();
}
