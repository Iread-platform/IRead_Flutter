import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationExtraInfo {
  String _route;
  String _message;

  NotificationExtraInfo.fromJson(Map<String, dynamic> json) {
    _route = json['GoTo'];
    _message = json['Messsage'];
  }

  get route => _route;
  get message => _message;
}
