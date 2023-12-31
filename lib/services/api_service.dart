import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:iread_flutter/services/auth_service.dart';
import 'package:iread_flutter/utils/exception.dart';

import 'settings.dart' as appSettings;

enum RequestType { GET, POST, PUT, DELETE }

class ApiService {
  static final ApiService _instance = ApiService._internal();
  final String baseUrl = "http://217.182.250.236:5014/api/iread";

  factory ApiService() => _instance;

  ApiService._internal();

  final Client _client = Client();
  final String testAuthKey =
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0ZXN0Iiwicm9sZSI6IkJpZGRlciIsImp0aSI6ImE0ZDAzNzc1LWU3YmUtNDM0YS04NjRmLWJkNzRhNDY1ODhkZiIsImV4cCI6MTYxNjUwNTAzMywiaXNzIjoiaHR0cHMvL2xvY2FsaG9zdDo0NDMzOC8iLCJhdWQiOiJodHRwcy8vbG9jYWxob3N0OjQ0MzM4LyJ9.wlSMq8ldhDdfAWsyUPd035m0gTJYIXTbN6mNNBDo1C4";

  Future<String> request(
      {@required RequestType requestType,
      @required String endPoint,
      dynamic parameter,
      String contentType,
      bool convertParametersToJson = true,
      String externalToken}) async {
    Uri url = Uri.parse("$baseUrl/$endPoint");
    print("url is: $url");

    switch (requestType) {
      case RequestType.GET:
        return await _processResponse(await _client.get(
          url,
          headers: {
            "Accept": "application/json",
            "Content-Type": contentType ?? "application/json",
            "Authorization":
                externalToken ?? AuthService().cU?.token ?? testAuthKey
          },
        ));
      case RequestType.POST:
        print("Post");
        return await _processResponse(await _client.post(url,
            headers: {
              "Accept": "application/json",
              "Content-Type": contentType ?? "application/json",
              "Authorization":
                  externalToken ?? AuthService().cU?.token ?? testAuthKey
            },
            body: convertParametersToJson ? json.encode(parameter) : parameter,
            encoding: Encoding.getByName("utf-8")));
      case RequestType.PUT:
        return await _processResponse(await _client.put(url,
            headers: {
              "Accept": "application/json",
              "Content-Type": contentType ?? "application/json",
              "Authorization":
                  externalToken ?? AuthService().cU?.token ?? testAuthKey
            },
            body: convertParametersToJson ? json.encode(parameter) : parameter,
            encoding: Encoding.getByName("utf-8")));
      case RequestType.DELETE:
        return await _processResponse(await _client.delete(url));
      default:
        return null;
    }
  }

  Future<String> _processResponse(Response response) async {
    print('status is ${response.statusCode}\nresponse is \n${response.body}');
    switch (response.statusCode) {
      case 204:
      case 201:
      case 200:
        {
          return response.body;
        }
      case 400:
        {
          List errors = json.decode(response.body);
          String message = errors[errors.length - 1];

          throw NetworkException(
              message: message,
              logMessage: appSettings.Settings.HTTP_REQUEST_STATE_CODE[400]);
        }
      case 401:
        {
          throw NetworkException(
              message: appSettings.Settings.HTTP_REQUEST_STATE_CODE[401]);
        }
      case 403:
        {
          throw NetworkException(
              message: appSettings.Settings.HTTP_REQUEST_STATE_CODE[403]);
        }
      case 404:
        {
          throw NetworkException(
              message: appSettings.Settings.HTTP_REQUEST_STATE_CODE[404],
              logMessage: appSettings.Settings.HTTP_REQUEST_STATE_CODE[404]);
        }
      case 408:
        {
          throw NetworkException(
              message: appSettings.Settings.HTTP_REQUEST_STATE_CODE[408]);
        }
      case 500:
        {
          throw NetworkException(
              message: appSettings.Settings.HTTP_REQUEST_STATE_CODE[500]);
        }
      default:
        {
          throw NetworkException(
              message:
                  "Unknown Error, status code is ${response.statusCode}\n\nMessage is $response");
        }
    }
  }
}
