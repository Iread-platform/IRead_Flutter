import 'package:flutter/material.dart';
import 'package:iread_flutter/themes/border_radius.dart';
import 'package:iread_flutter/views/widgets/layout/responsive_layout_builder.dart';
import 'package:iread_flutter/views/widgets/story/story_image.dart';

class ProfileStoryCard extends StatelessWidget {
  final String _readingTimeTitle = 'Reading Time';
  final String _flippedTimePages = 'Flipped Pages';
  final String _imageUrl;
  final Color _color;
  final double _progress;
  final int _flippedPages;
  final double _readingTime;

  ProfileStoryCard(
      {Key key,
      @required imageUrl,
      @required color,
      progress,
      @required title,
      flippedPages,
      readingTime})
      : _imageUrl = imageUrl,
        _color = color,
        _progress = progress ?? 0,
        _flippedPages = flippedPages,
        _readingTime = readingTime,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(flex: 2, child: Container()),
              Flexible(flex: 3, child: _storyDetails(context))
            ],
          ),
          Row(
            children: [
              Flexible(
                  flex: 2,
                  child: StoryImage(imageUrl: _imageUrl, color: _color)),
              Flexible(flex: 3, child: Container())
            ],
          ),
        ],
      ),
    );
  }

  Widget _storyDetails(BuildContext context) => Container(
        padding: EdgeInsets.only(top: 24, bottom: 8),
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: ResponsiveLayoutBuilder(
                    onXSm: (context) => _storyPagesAndTime(context, 12),
                    onSm: (context) => _storyPagesAndTime(context, 32))),
            Expanded(flex: 1, child: _storyProgress(context, 12)),
          ],
        ),
      );

  Widget _storyPagesAndTime(BuildContext context, double leftPadding) =>
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(smallBorderRadius),
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  offset: Offset(1, 0),
                  spreadRadius: -1)
            ]),
        padding:
            EdgeInsets.only(left: leftPadding, top: 8, bottom: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _detailsRow(
                  context, _readingTimeTitle, _readingTime.toString() + ' m'),
            ),
            Expanded(
              child: _detailsRow(context, _flippedTimePages,
                  _flippedPages.toString() + ' pages'),
            )
          ],
        ),
      );

  Widget _detailsRow(BuildContext context, String key, String value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );

  Widget _storyProgress(BuildContext context, double leftPadding) {
    return Container(
      padding: EdgeInsets.only(left: leftPadding, right: 8),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(smallBorderRadius),
        color: _color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 10,
            child: Container(
              height: 12,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: Theme.of(context).colorScheme.surface),
                  borderRadius: BorderRadius.circular(storyBorderRadius)),
              margin: EdgeInsets.only(right: 12),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(_color),
                value: _progress,
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Text(
              _progress.toString() + '%',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Theme.of(context).colorScheme.surface),
            ),
          )
        ],
      ),
    );
  }
}
