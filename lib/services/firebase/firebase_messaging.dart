import 'package:firebase_messaging/firebase_messaging.dart';

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
    await _messaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
