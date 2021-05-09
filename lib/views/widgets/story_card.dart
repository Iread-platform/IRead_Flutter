import 'package:flutter/material.dart';
import 'package:iread_flutter/themes/border_radius.dart';

class StoryCard extends StatelessWidget {
  final double _progress;
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
      children: [
        _storyCardImage(context),
        _studentProgress(context),
        _storyTitle(context)
      ],
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(color: _color, width: 1),
            borderRadius: BorderRadius.circular(storyBorderRadius)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(storyBorderRadius),
          child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).colorScheme.surface,
            value: _progress,
            valueColor: AlwaysStoppedAnimation<Color>(_color),
            minHeight: 8,
          ),
        ),
      ),
    );
  }

  Widget _storyTitle(BuildContext context) => Text(_title,
      style: Theme.of(context).textTheme.subtitle1.copyWith(color: _color));
}
