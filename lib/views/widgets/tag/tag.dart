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
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(storyBorderRadius),
          boxShadow: [BoxShadow()]),
    );
  }
}
