import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Validator {
  // Return true if the value is not valid
  static bool isRequired(String value) {
    return !(value == null || value.isEmpty);
  }

  static bool isPhone(String value) {
    final phoneRegex = RegExp(r'^(?:[+0]9)?[0-9]{10,13}$');
    return phoneRegex.hasMatch(value);
  }

  static bool isUserName(String value) {
    final phoneRegex = RegExp(r'^(?:[+0]9)?[0-9]{10,13}$');
    return phoneRegex.hasMatch(value);
  }

  static bool isEmail(String value) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return emailRegex.hasMatch(value);
  }

  static bool isBirthDate(DateTime value) {
    // Birth date must be before now.
    if (DateTime.now().isBefore(value)) {
      return false;
    }

    return true;
  }

// ============= Login Screen Validation ===============
  static String validUserName(String value) {
    if (value.trim().isEmpty) {
      return "Field can't be empty";
    } else if (value.trim().length < 4) {
      return "User Name Must Be More Than 4 ";
    } else {
      return null;
    }
  }

  static String validPassword(String value) {
    if (value.trim().isEmpty) {
      return "Field Can't Be Empty";
    } else {
      return null;
    }
  }

  static Widget showMessage(
      {@required context,
      @required String message,
      @required icon,
      @required color,
      durationSec = 3}) {
    var f = FToast();
    f.init(context);
    f.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0), color: color),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: durationSec),
    );
  }
//=============================================
}
