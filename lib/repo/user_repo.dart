import 'dart:convert';

import 'package:iread_flutter/models/attachment/attachment.dart';
import 'package:iread_flutter/models/user/profile.dart';
import 'package:iread_flutter/models/user/user.dart';
import 'package:iread_flutter/models/user/user_update.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'package:iread_flutter/services/auth_service.dart';
import 'package:iread_flutter/utils/data.dart';

class UserRepo {
  static final UserRepo _instance = UserRepo._internal();

  final ApiService _apiService = ApiService();

  Profile profile;

  final loginEndPoint = "connect/token";
  final myProfileEndPoint = "identity/myProfile";
  final avatarsEndPoint = "Avatar/all";
  final userUpdateEndPoint = "Identity/UpdateStudentInfo/";

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

      final userResponse =
          await _fetchProfileJson("Bearer " + jsonResponse['access_token']);
      // this.profile = Profile.fromJson(userResponse);

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

  Future<Data<Profile>> fetchProfile() async {
    if (profile != null) {
      return Data.success(profile);
    }

    try {
      final json = await _fetchProfileJson(AuthService().cU.token);
      profile = Profile.fromJson(json);
      return Data.success(profile);
    } catch (e) {
      return Data.handleException(e);
    }
  }

  Future<Data<List<Attachment>>> fetchUserAvatars() async {
    final response = await _apiService.request(
        requestType: RequestType.GET, endPoint: avatarsEndPoint);
    final json = jsonDecode(response);
    final List<Attachment> avatars = [];

    for (final avatarJson in json) {
      avatars.add(Attachment.fromJson(avatarJson));
    }

    return Data.success(avatars);
  }

  _fetchProfileJson(String accessToken) async {
    String userText = await _apiService.request(
        convertParametersToJson: false,
        requestType: RequestType.GET,
        endPoint: myProfileEndPoint,
        externalToken: accessToken);

    return json.decode(userText.toString());
  }

  Future<Data<Profile>> updateUserAvatar(int id,
      {bool isPersonal = false}) async {
    UserUpdate data = UserUpdate(
        firstName: profile.firstName,
        lastName: profile.lastName,
        avatarId: isPersonal ? 0 : id,
        birthDay: profile.birthDay,
        customPhotoId: isPersonal ? id : 0,
        email: profile.email,
        level: profile.level);

    return updateUser(data);
  }

  Future<Data<Profile>> updateUser(UserUpdate data) async {
    final response = await _apiService.request(
      requestType: RequestType.PUT,
      endPoint: userUpdateEndPoint + AuthService().cU.id,
      parameter: data,
    );

    final json = jsonDecode(response);

    return Data.success(Profile());
  }
}
