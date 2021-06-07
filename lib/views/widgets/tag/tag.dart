import 'package:flutter/material.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';

class Tag extends StatelessWidget {
  final String _title;

  const Tag({String title, Key key})
      : _title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(storyBorderRadius),
          boxShadow: [BoxShadow()]),
      child: Text(
        _title,
        style: Theme.of(context)
            .textTheme
            .subtitle2
            .copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
