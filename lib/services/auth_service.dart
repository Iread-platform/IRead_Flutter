import 'dart:convert';

import 'package:iread_flutter/models/user/user.dart';
import 'package:iread_flutter/utils/extensions.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;
  User cU;
  AuthService._internal();

  static const String _USER_SHARED_PREFERENCES_KEY = "USER";

  static BehaviorSubject<User> _currentUserStream = BehaviorSubject();

  Stream<User> get currentUserStream => _currentUserStream.stream;

  // Save user using shared preferences
  void saveUser(User user) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Save user as json
    preferences.setString(_USER_SHARED_PREFERENCES_KEY, json.encode(user.toJson()));
    User userdecode = User.fromJson(json.decode(preferences.getString(_USER_SHARED_PREFERENCES_KEY)));
    print(userdecode.toJson());
    cU = user;
    _currentUserStream.sink.add(user);
  }

  // Save user using shared preferences
  void removeUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Load user json string
    preferences.remove(_USER_SHARED_PREFERENCES_KEY);
    _currentUserStream.sink.add(null);
  }

  String getUserFullName()
  {
    print(cU.toJson());
    return cU.firstName + " " + cU.lastName;
  }
  // Load user model
  Future<void> loadUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Load user json string
    final userJson = preferences.getString(_USER_SHARED_PREFERENCES_KEY);

    // Return null if the user data is not stored.
    if (userJson.isNullOrEmpty()) {
      _currentUserStream.sink.add(null);
      return;
    }
    User user = User.fromJson(json.decode(userJson));
    _currentUserStream.sink.add(user);
    cU = user;
  }

  void dispose() {
    _currentUserStream.close();
  }
}
