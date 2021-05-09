import 'package:flutter/material.dart';
import 'package:iread_flutter/themes/border_radius.dart';

class StoryCard extends StatelessWidget {
  final int _progress;
  final String _title;
  final String _imageUrl;
  final Color _color;

  StoryCard({
    @required title,
    @required imageUrl,
    @required color,
    progress,
  })  : _progress = progress ?? 0,
        _title = title,
        _color = color,
        _imageUrl = imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      padding: EdgeInsets.only(left: 12, top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(storyBorderRadius),
          color: _color),
      child: Container(
        child: Image.network(_imageUrl),
      ),
    );
  }
}
