import 'package:iread_flutter/services/api_service.dart';

class MainRepo {
  static final MainRepo _instance = MainRepo._internal();

  final ApiService apiService = ApiService();

  factory MainRepo() => _instance;
  MainRepo._internal();
}
