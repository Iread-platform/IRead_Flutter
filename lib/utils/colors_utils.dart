import 'package:flutter/material.dart';

class AppColors{
  static const MaterialColor orange = MaterialColor(_orangePrimaryValue, <int, Color>{
    50: Color(0xFFFCEEEA),
    100: Color(0xFFF8D4CB),
    200: Color(0xFFF3B7A8),
    300: Color(0xFFEE9A85),
    400: Color(0xFFEB856B),
    500: Color(_orangePrimaryValue),
    600: Color(0xFFE4674A),
    700: Color(0xFFE05C40),
    800: Color(0xFFDD5237),
    900: Color(0xFFD74027),
  });
  static const int _orangePrimaryValue = 0xFFE76F51;

  static const MaterialColor gray = MaterialColor(_grayPrimaryValue, <int, Color>{
    50: Color(0xFFF0F0F0),
    100: Color(0xFFD9D9D9),
    200: Color(0xFFC0C0C0),
    300: Color(0xFFA6A6A6),
    400: Color(0xFF939393),
    500: Color(_grayPrimaryValue),
    600: Color(0xFF787878),
    700: Color(0xFF6D6D6D),
    800: Color(0xFF636363),
    900: Color(0xFF505050),
  });
  static const int _grayPrimaryValue = 0xFF808080;

  static const MaterialColor input = MaterialColor(_inputPrimaryValue, <int, Color>{
    50: Color(0xFFF1E6E3),
    100: Color(0xFFDDBFB8),
    200: Color(0xFFC69589),
    300: Color(0xFFAF6B5A),
    400: Color(0xFF9D4B36),
    500: Color(_inputPrimaryValue),
    600: Color(0xFF842611),
    700: Color(0xFF79200E),
    800: Color(0xFF6F1A0B),
    900: Color(0xFF5C1006),
  });
  static const int _inputPrimaryValue = 0xFF8C2B13;

  static const MaterialColor facebook = MaterialColor(_facebookPrimaryValue, <int, Color>{
    50: Color(0xFFE7EBF3),
    100: Color(0xFFC4CDE0),
    200: Color(0xFF9DACCC),
    300: Color(0xFF768BB7),
    400: Color(0xFF5872A7),
    500: Color(_facebookPrimaryValue),
    600: Color(0xFF355190),
    700: Color(0xFF2D4885),
    800: Color(0xFF263E7B),
    900: Color(0xFF192E6A),
  });
  static const int _facebookPrimaryValue = 0xFF3B5998;

  static const MaterialColor gmail = MaterialColor(_gmailPrimaryValue, <int, Color>{
    50: Color(0xFFFBE9E7),
    100: Color(0xFFF5C9C4),
    200: Color(0xFFEEA59C),
    300: Color(0xFFE78174),
    400: Color(0xFFE26657),
    500: Color(_gmailPrimaryValue),
    600: Color(0xFFD94433),
    700: Color(0xFFD43B2C),
    800: Color(0xFFCF3324),
    900: Color(0xFFC72317),
  });
  static const int _gmailPrimaryValue = 0xFFDD4B39;

  static const MaterialColor twitter = MaterialColor(_twitterPrimaryValue, <int, Color>{
    50: Color(0xFFEBF5FD),
    100: Color(0xFFCCE6FA),
    200: Color(0xFFAAD6F7),
    300: Color(0xFF88C5F3),
    400: Color(0xFF6FB8F1),
    500: Color(_twitterPrimaryValue),
    600: Color(0xFF4EA5EC),
    700: Color(0xFF449BE9),
    800: Color(0xFF3B92E7),
    900: Color(0xFF2A82E2),
  });
  static const int _twitterPrimaryValue = 0xFF55ACEE;

  static const MaterialColor lightgray = MaterialColor(_lightgrayPrimaryValue, <int, Color>{
    50: Color(0xFFFEFEFE),
    100: Color(0xFFFCFCFC),
    200: Color(0xFFFAFAFA),
    300: Color(0xFFF8F8F8),
    400: Color(0xFFF7F7F7),
    500: Color(_lightgrayPrimaryValue),
    600: Color(0xFFF4F4F4),
    700: Color(0xFFF2F2F2),
    800: Color(0xFFF0F0F0),
    900: Color(0xFFEEEEEE),
  });
  static const int _lightgrayPrimaryValue = 0xFFF5F5F5;
}