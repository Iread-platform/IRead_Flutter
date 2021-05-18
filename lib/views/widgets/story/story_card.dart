import 'package:flutter/material.dart';
import 'package:iread_flutter/configs/themes/border_radius.dart';
import 'package:iread_flutter/views/widgets/shared/progress_bar.dart';
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
        child: ProgressBar(
          borderRadius: storyBorderRadius,
          color: _color,
          height: 12,
          progress: _progress,
          borderWidth: 2,
          padding: 1,
          dropShadow: true,
          shadowOffset: Offset(1, 1),
          shadowBlurRadius: 10,
        ));
  }

  Widget _storyTitle(BuildContext context) => Text(_title,
      style: Theme.of(context).textTheme.subtitle1.copyWith(color: _color));
}
