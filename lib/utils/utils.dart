import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m3allem_flutter/common/settings.dart' as app_settings;
import 'package:m3allem_flutter/config/themes/color_scheme.dart';
import 'package:m3allem_flutter/model/data.dart';
import 'package:m3allem_flutter/view/widgets/dialog_widget.dart';
import 'package:m3allem_flutter/view/widgets/result_placeholder.dart';

typedef OnLoading = Widget Function(BuildContext, Data);
typedef OnError = Widget Function(BuildContext, Data);
typedef OnSuccess = Widget Function(BuildContext, Data);

class Utils {
  /// Show a custom widget as a material dialog [content] and use custom
  /// [actions] if needed.
  ///
  /// *** Parameters ***
  /// * [context] The context of the position where the action is triggered.
  /// * [title] : `String` The title of the dialog.
  /// * [dimissable] : `bool` if `false` the dialog will be closed only by
  /// popping it from the navigator, or it will behave normally when it is
  /// `true`.
  /// * [actions] : List<Widget> A list of widgets `buttons` that can do a
  /// specific action. They will be sorted at the bottom of the dialog.
  /// * [color] : `Color` ackground color of the dialog.
  ///
  /// *** Return ***
  ///
  /// Returns `dynamic` The returned value when popping the dialog from the
  /// Navigator.
  static Future<dynamic> showCustomDialog(
    BuildContext context, {
    Widget content,
    String title,
    bool dimissable = true,
    List<Widget> actions,
    Color color,
  }) async {
    var returnedValue = await showDialog(
        barrierDismissible: dimissable,
        context: context,
        builder: (context) => Padding(
            padding: EdgeInsets.all(10),
            child: CustomDialog(
              title: title,
              content: content,
              actions: actions,
            )));

    return returnedValue;
  }

  /// Check if [o] is null or empty.
  ///
  /// *** Parameters ***
  /// * [o] the given object.
  ///
  /// *** Return ***
  ///
  /// Returns `false` if the object is null or empty, or `true` otherwise.
  static bool isNullOrEmpty(dynamic o) => o == null
      ? true
      : false || (o is String)
          ? o == ""
          : false || (o is Map)
              ? (o as Map).length == 0
              : false || (o is List)
                  ? (o as List).length == 0 || o == null
                  : false;

  static Future<dynamic> showIrremovableErrorMessage(
    BuildContext context, {
    List<Widget> actions,
    String message,
    Color color,
  }) async {
    var value = await Utils.showCustomDialog(
      context,
      dimissable: false,
      actions: actions,
      content: WillPopScope(child: Text(message), onWillPop: () async => false),
    );
    return value;
  }

  /// Handles backend requests in UI.
  /// Mostly a streambuilder's builder.
  ///
  /// [context] is the parent widget BuildContext.
  ///
  /// [data] is the result of backend request.
  ///
  /// [onLoading] will be used when the [data.status] is `inProgress`,
  /// A circular indicator by default.
  ///
  /// [onError]  used when the [data.status] is `failed`, Or an
  /// `ResultPlaceholder` widget will be used instead.
  ///
  /// [onSuccess] the widget to show when [data.status] is `succeed` .
  static Widget requestHandler(BuildContext context, Data data,
      {OnLoading onLoading,
      OnError onError,
      OnSuccess onSuccess,
      Widget child}) {
    Widget result;
    if (data == null) {
      return Center(
        child: SizedBox(
            child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation(colorScheme.primary),
        )),
      );
    }
    switch (data.status) {
      case app_settings.DataStatus.faild:
        {
          result = onError != null
              ? onError(context, data)
              : ResultPlaceholder(
                  text: data.message,
                  image: data.errorType == app_settings.ErrorType.network
                      ? "assets/illustrations/network_error.svg"
                      : data.errorType == app_settings.ErrorType.emptyResponse
                          ? "assets/illustrations/empty_response_error.svg"
                          : "assets/illustrations/general_error.svg",
                );
          break;
        }
      case app_settings.DataStatus.succeed:
        {
          result = onSuccess != null
              ? onSuccess(context, data)
              : ResultPlaceholder(
                  text: data.message,
                  image: "assets/illustrations/success.svg",
                );
          break;
        }
      case app_settings.DataStatus.none:
        {
          result = ResultPlaceholder(
            image: "assets/illustrations/empty_response_error.svg",
            text: "No Data Found.",
          );
          break;
        }
      case app_settings.DataStatus.inProgress:
        {
          result = onLoading != null
              ? onLoading(context, data)
              : Center(
                  child: SizedBox(
                      child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation(colorScheme.primary),
                  )),
                );
          break;
        }
      default:
        {
          result = child ??
              ResultPlaceholder(
                text: data.message,
              );
        }
    }
    return result;
  }
}
