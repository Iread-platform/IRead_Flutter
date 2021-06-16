import 'package:flutter/cupertino.dart';

enum DataState { Success, Fail }

class Data<T> {
  T _data;
  DataState _dataState;
  String _message;

  Data.success({@required T data})
      : _data = data,
        _dataState = DataState.Success;

  Data.fail({@required String message})
      : _dataState = DataState.Fail,
        _message = message;
}
