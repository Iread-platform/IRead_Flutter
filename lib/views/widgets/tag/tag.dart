import 'package:flutter/material.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';

class Tag extends StatelessWidget {
  final String _title;

  const Tag({String title, Key key})
      : _title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        _title,
        style: Theme.of(context)
            .textTheme
            .subtitle2
            .copyWith(color: Theme.of(context).colorScheme.primary),
      ),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(storyBorderRadius)),
          elevation: 4,
          shadowColor: Colors.black38),
    );
  }
}
