import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:iread_flutter/config/app_config.dart';
import 'package:iread_flutter/config/routing/app_router.dart';
import 'package:iread_flutter/models/notifIcation_extra_info.dart';

class NotificationsManagerService {
  static NotificationsManagerService _instance =
      NotificationsManagerService.internal();

  NotificationsManagerService.internal();

  factory NotificationsManagerService.instance() => _instance;

  FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  NotificationDetails _platformChannelSpecifics;

  Future<void> init() async {
    _localNotifications.initialize(
        InitializationSettings(
            AndroidInitializationSettings("@mipmap/ic_launcher"),
            IOSInitializationSettings()),
        onSelectNotification: onSelectNotification);

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails("Channel_id", "channel1", "channel+desc");

    IOSNotificationDetails iosPlatformChannelSpecifics =
        IOSNotificationDetails();
    _platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iosPlatformChannelSpecifics);
  }

  static Future<dynamic> onSelectNotification(String data) async {
    if (data != null) {
      Map<String, dynamic> notificationsInfo = jsonDecode(data);
      NotificationExtraInfo notificationExtraInfo =
          NotificationExtraInfo.fromJson(notificationsInfo);

      AppRouter().navigate(
          AppConfigs.instance().appContext, notificationExtraInfo.route);
    }
  }

  Future<void> showNotification(String title, String body,
      {String payload}) async {
    _localNotifications.show(0, title, body, _platformChannelSpecifics,
        payload: payload);
  }
}
