import 'package:flutter/material.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';
import 'package:iread_flutter/config/themes/colors.dart';
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
    @required String title,
    @required String imageUrl,
    @required Color color,
    double progress,
  })  : _progress = progress ?? -1,
        _title = title,
        _color = color,
        _imageUrl = imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: ProgressBar(
          borderRadius: storyBorderRadius,
          color: _color,
          height: 12.0,
          progress: _progress,
          borderWidth: 2.0,
          padding: 1.0,
          dropShadow: true,
          shadowOffset: Offset(1, 1),
          shadowBlurRadius: 10.0,
        ));
  }

  Widget _storyTitle(BuildContext context) => Flexible(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Text(
              _title,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: colorScheme.primary, fontWeight: FontWeight.w300),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
      );
}
