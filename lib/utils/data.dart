import 'dart:developer';

import 'package:iread_flutter/utils/exception.dart';

enum DataState { Success, Fail }

class Data<T> {
  T _data;
  DataState _dataState;
  String _message;

  Data.success(T data)
      : _data = data,
        _dataState = DataState.Success;

  Data.fail(String message)
      : _dataState = DataState.Fail,
        _message = message;

  static Data<T> handleException<T>(Exception e) {
    if (e is NetworkException) {
      return Data.fail(e.message);
    } else {
      log(e.toString());
      return Data.fail("Unknown error");
    }
  }

  get data => _data;
  get state => _dataState;
  get message => _message;
}
