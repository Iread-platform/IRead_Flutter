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
  })  : _progress = progress ?? -1,
        _title = title,
        _color = color,
        _imageUrl = imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_storyCardImage(context)],
    );
  }

  Widget _storyCardImage(BuildContext context) => Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.only(left: 12, top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(storyBorderRadius),
            color: _color,
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(1, 0))
            ]),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(storyBorderRadius),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 5, offset: Offset(-1, 0))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(storyBorderRadius)),
            child: Image.network(
              _imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  Widget _studentProgress(BuildContext context) {
    // If this story do not have a progress bar.
    if (_progress < 0) {
      return SizedBox(
        width: 0,
        height: 0,
      );
    }
  }
}
