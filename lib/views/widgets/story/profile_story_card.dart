import 'package:flutter/material.dart';
import 'package:iread_flutter/themes/border_radius.dart';
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
            children: [
              Flexible(flex: 2, child: Container()),
              Flexible(flex: 4, child: _storyDetails(context)),
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
        margin: EdgeInsets.only(top: 16, bottom: 8, left: 12),
        child: Column(
          children: [
            Expanded(flex: 3, child: _storyPagesAndTime(context)),
            Expanded(flex: 1, child: _storyProgress(context)),
          ],
        ),
      );

  Widget _storyPagesAndTime(BuildContext context) => Container(
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
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _detailsRow(
                context, _readingTimeTitle, _readingTime.toString() + ' m'),
            _detailsRow(
                context, _flippedTimePages, _flippedPages.toString() + 'page')
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

  Widget _storyProgress(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(smallBorderRadius),
        color: _color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 5,
            child: Container(
              height: 12,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: Theme.of(context).colorScheme.surface),
                  borderRadius: BorderRadius.circular(storyBorderRadius)),
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(_color),
                value: _progress,
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
          Flexible(
            flex: 1,
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
