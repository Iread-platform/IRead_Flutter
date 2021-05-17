import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/config/router/app_routes.dart';
import 'package:iread_flutter/utils/extensions.dart';

class AppRouter {
  static AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;
  FluroRouter _router;
  AppRouter._internal() : _router = FluroRouter.appRouter;
  List<AppRoute> _routes;
  get appRouterGenerator => _router.generator;

  Future<void> init() async {
    _routes = AppRoutes.appRoutes;
    _router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return;
    });
    for (AppRoute route in _routes) {
      _router.define(route.route, handler: route.handler);
    }
  }

  /// Navigate to a specific path.
  void navigate(BuildContext context, String path) {
    assert(!context.isNullOrEmpty() && !path.isNullOrEmpty());
    _router.navigateTo(context, path);
  }
}
