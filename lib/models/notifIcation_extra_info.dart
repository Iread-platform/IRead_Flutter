import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationExtraInfo {
  String _route;
  String _message;

  NotificationExtraInfo.fromJson(Map<String, dynamic> json) {
    _route = json['goTo'];
    _message = json['messsage'];
  }

  get route => _route;
  get message => _message;
}
