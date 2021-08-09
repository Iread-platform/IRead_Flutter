import 'package:flutter/cupertino.dart';

class AppConfigs {
  static AppConfigs _instance = AppConfigs._internal();
  AppConfigs._internal() : navigationKey = GlobalKey<NavigatorState>();

  factory AppConfigs.instance() => _instance;

  /*Future<void> init() async {
    await AuthService().loadUser();
    await AppRouter().init();
  }*/

  GlobalKey navigationKey;

  State get appCurrentState => navigationKey.currentState;
}
