import 'package:flutter/material.dart';
import 'package:iread_flutter/themes/border_radius.dart';
import 'package:iread_flutter/views/widgets/story/story_image.dart';

/// [progress] determines progress bar value, if progress is not exist
///  progress bar do not show.
/// [title] refer to story title that show below, it is 'required'.
/// [imageUrl] refer to network image url, It is 'required'.
/// [color] refer to the color of background, progressbar, and title,
/// It's required.

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
        StoryImage(imageUrl: _imageUrl, color: _color),
        _studentProgress(context),
        _storyTitle(context)
      ],
    );
  }

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
