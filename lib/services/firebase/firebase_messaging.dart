import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:iread_flutter/services/notifications_manager_service.dart';

import 'firebase_base_service.dart';

class FirebaseMessagingService extends FirebaseBaseService {
  static FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();

  FirebaseMessagingService._internal();

  factory FirebaseMessagingService.instance() => _instance;

  FirebaseMessaging _messaging;

  @override
  Future<void> init() async {
    _messaging = FirebaseMessaging.instance;
    print(await _messaging.getToken());
    await _messaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print(
          '1=========================================================================================');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        NotificationsManagerService.instance().showNotification();
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // FirebaseMessaging.onBackgroundMessage((message) {
    //   print(
    //       '2=========================================================================================');
    //   print(message.data);
    //   return;
    // });
  }
}
