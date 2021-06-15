import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/config/themes/colors.dart';

/// [RequestHandler] show widgets due to the [Data] object status.
/// [stream]] accepts [Stream] of [Future<Data>], [stream] is required.
/// [mainContent] is the main widget that you want to handle requests from.
/// [onSuccess] is the main widget when [Data] status is succeed, [onSuccess] is required.
/// [onFailed] is thw widget that appears when [Data] status is failed, [onFailed] has a default widget.
/// [inProgress] is the widget that appears when the [Data] status is in-progress, [inProgress] has a default value.
/// [isDismissible] is a boolean variable that indicates if you want user to
/// dismiss messages that shows upon the [mainContent] or not.
/// [other] is the widget that appears when the [Data] status is not one of the previous statuses, [other] has a default value.
class RequestHandler<T extends SuccessState,
    B extends Bloc<BlocEvent, BlocState>> extends StatefulWidget {
  final B _bloc;
  final Widget _mainContent;
  final Widget Function(BuildContext, T) _onSuccess;
  final Widget _onFailed;
  final Widget _inProgress;
  final Widget _other;
  final bool _isDismissible;

  RequestHandler(
      {@required main,
      @required Widget Function(BuildContext, T) onSuccess,
      onFailed,
      inProgress,
      other,
      isDismissible,
      @required B bloc})
      : _mainContent = main,
        _onSuccess = onSuccess,
        _onFailed = onFailed,
        _inProgress = inProgress,
        _other = other,
        _bloc = bloc,
        _isDismissible = isDismissible ?? true;

  @override
  _RequestHandlerState<T, B> createState() => _RequestHandlerState<T, B>();
}

class _RequestHandlerState<T extends SuccessState,
    B extends Bloc<BlocEvent, BlocState>> extends State<RequestHandler<T, B>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget._mainContent,
        Positioned.fill(
          child: BlocBuilder<B, BlocState>(
              bloc: widget._bloc,
              builder: (context, state) {
                // If request has not been initialized yet;
                if (state.state == DataState.Init)
                  return SizedBox(
                    width: 0,
                  );
                // If the request is in progress
                if (state.state == DataState.Loading) {
                  return widget._inProgress ??
                      Container(
                        color: Theme.of(context).colorScheme.background,
                        child: Center(child: CircularProgressIndicator()),
                      );

                  // If the response has been received
                } else {
                  switch (state.state) {
                    case DataState.Fail:
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          widget._onFailed ??
                              _InfoWidget.failed(message: state.message),
                          widget._isDismissible
                              ? Positioned(
                                  top: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      widget._bloc.add(CloseEvent());
                                    },
                                  ),
                                )
                              : SizedBox(
                                  width: 0,
                                )
                        ],
                      );
                    case DataState.Success:
                      // Build content widget on the data provided by the stream
                      return widget._onSuccess(context, state);
                    default:
                      return widget._other ??
                          _InfoWidget(message: "Unhandled Error");
                  }
                }
              }),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _InfoWidget extends StatelessWidget {
  final String _message;
  final TextStyle _textStyle;
  final Color _color;
  final Color _bgColor;

  _InfoWidget({@required message, messageTextStyle})
      : _message = message,
        _textStyle = messageTextStyle,
        _color = null,
        _bgColor = null;

  _InfoWidget.failed({@required message})
      : _message = message,
        _textStyle = null,
        _bgColor = colorScheme.error,
        _color = colorScheme.background;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _bgColor ?? Theme.of(context).colorScheme.background,
          ),
          padding: EdgeInsets.all(24),
          child: Text(
            _message,
            style: _textStyle ??
                Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: _color ?? colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
