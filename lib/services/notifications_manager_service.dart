import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    print("data with notification ======================" + data);
    return data;
  }

  Future<void> showNotification(String title, String body,
      {String payload}) async {
    _localNotifications.show(0, title, body, _platformChannelSpecifics,
        payload: payload);
  }
}
