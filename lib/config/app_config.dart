import 'package:flutter/cupertino.dart';

class AppConfigs {
  static AppConfigs _instance = AppConfigs._internal();
  AppConfigs._internal() : navigationKey = GlobalKey<NavigatorState>();

  factory AppConfigs.instance() => _instance;

  GlobalKey navigationKey;
  BuildContext appContext;

  State get appCurrentState => navigationKey.currentState;
}
