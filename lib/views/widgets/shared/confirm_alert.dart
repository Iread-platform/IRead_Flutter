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
        _message = message ?? 'Do you want to confirm th operation ?',
        _title = title ?? 'Confirm',
        _confirmButtonLabel = confirmButtonLabel ?? 'Confirm',
        _cancelButtonLabel = cancelButtonLabel ?? 'Cancel',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm'),
      content: Column(
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
                  child: Text(_confirmButtonLabel)),
              SizedBox(
                width: 12,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(_cancelButtonLabel)),
            ],
          )
        ],
      ),
    );
  }
}
