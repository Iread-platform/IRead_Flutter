import 'package:flutter/material.dart';

class ConfirmAlert extends StatelessWidget {
  final String _title;
  final String _message;
  final String _confirmButtonLabel;
  final String _cancelButtonLabel;
  final void Function() _onConfirm;
  const ConfirmAlert(
      {@required void Function() onConfirm,
      String title,
      String message,
      String confirmButtonLabel,
      String cancelButtonLabel,
      Key key})
      : _onConfirm = onConfirm,
        _message = message ?? 'Do you want to confirm the operation ?',
        _title = title ?? 'Confirm',
        _confirmButtonLabel = confirmButtonLabel ?? 'Confirm',
        _cancelButtonLabel = cancelButtonLabel ?? 'Cancel',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: Text(_title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _message,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      _onConfirm();
                      Navigator.pop(context);
                    },
                    child: Text(
                      _confirmButtonLabel,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: Theme.of(context).colorScheme.error),
                    )),
                SizedBox(
                  width: 12,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(_cancelButtonLabel,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
