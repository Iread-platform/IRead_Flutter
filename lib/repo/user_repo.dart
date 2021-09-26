import 'dart:convert';

import 'package:iread_flutter/models/user/user.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'package:iread_flutter/services/auth_service.dart';
import 'package:iread_flutter/utils/data.dart';

class UserRepo {
  static final UserRepo _instance = UserRepo._internal();

  final ApiService _apiService = ApiService();

  final loginEndPoint = "connect/token";
  final myProfileEndPoint = "identity/myProfile";

  factory UserRepo() => _instance;
  UserRepo._internal();

  Future<Data<bool>> login(String email, String password) async {
    try {
      final url = '$loginEndPoint';
      final jsonText = await _apiService.request(
        convertParametersToJson: false,
        requestType: RequestType.POST,
        endPoint: url,
        contentType: "application/x-www-form-urlencoded",
        parameter: {
          "username": email,
          "password": password,
          "client_id": "iread_identity_ms",
          "client_secret": "!re@d",
          "grant_type": "password"
        },
      );

      final jsonResponse = json.decode(jsonText);
      print(jsonResponse['access_token']);

      String userText = await _apiService.request(
          convertParametersToJson: false,
          requestType: RequestType.GET,
          endPoint: myProfileEndPoint,
          externalToken: "Bearer " + jsonResponse['access_token']);

      final userResponse = json.decode(userText.toString());

      User user = User(
        token: "Bearer " + jsonResponse['access_token'],
        firstName: userResponse['firstName'],
        lastName: userResponse['lastName'],
        id: userResponse['id'],
        userRole: UserRole.values.firstWhere((element) =>
            element.toString() == "UserRole." + userResponse['role']),
        email: userResponse['email'],
        imageUrl: userResponse['email'],
      );
      //print(user.toJson().toString());
      AuthService().saveUser(user);

      return Data.success(true);
    } catch (e) {
      throw e;
    }
  }

  Data<User> profile() {
    final response = _apiService.request(
        requestType: RequestType.GET, endPoint: myProfileEndPoint);
    return Data.success(AuthService().cU);
  }
}
