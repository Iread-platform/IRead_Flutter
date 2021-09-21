import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsManagerService {
  static NotificationsManagerService _instance =
      NotificationsManagerService.internal();

  NotificationsManagerService.internal();

  factory NotificationsManagerService.instance() => _instance;

  FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  NotificationDetails _platformChannelSpecifics;

  Future<void> init(
      {Future<dynamic> Function(String) onSelectNotification}) async {
    _localNotifications.initialize(
        InitializationSettings(AndroidInitializationSettings("app_Icon"),
            IOSInitializationSettings()),
        onSelectNotification: onSelectNotification);

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails("Channel_id", "channel1", "channel+desc");

    IOSNotificationDetails iosPlatformChannelSpecifics =
        IOSNotificationDetails();
    _platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iosPlatformChannelSpecifics);
  }

  Future<void> showNotification() async {
    _localNotifications.show(0, "notification title", "notification body",
        _platformChannelSpecifics);
  }
}
