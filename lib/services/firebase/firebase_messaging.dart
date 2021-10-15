import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:iread_flutter/services/notifications_manager_service.dart';

import 'firebase_base_service.dart';

class FirebaseMessagingService extends FirebaseBaseService {
  static FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();

  FirebaseMessagingService._internal();

  factory FirebaseMessagingService.instance() => _instance;

  FirebaseMessaging _messaging;

  Future<String> getDeviceToken() async {
    return await _messaging.getToken();
  }

  @override
  Future<void> init() async {
    _messaging = FirebaseMessaging.instance;
    print(await _messaging.getToken());
    await _messaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        NotificationsManagerService.instance().showNotification(
            message.notification.title, message.notification.body,
            payload: jsonEncode(message.data));
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
