import 'package:flutter/material.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/story_details_card_template.dart';

class ProfileStoryCard extends StatelessWidget {
  final Story _story;
  final String _readingTimeTitle = 'Reading Time';
  final String _flippedTimePages = 'Flipped Pages';

  ProfileStoryCard(
      {Key key,
      @required Story story,
      storyDetailsUpperSection,
      storyDetailsBottomSection})
      : _story = story,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoryDetailsCard(
      story: _story,
      upperSection: _storyPagesAndTime(context, 12),
      lowerSection: _storyProgress(context, 12),
    );
  }

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
                  context,
                  _readingTimeTitle,
                  (_story.readingTime != null
                          ? _story.readingTime.toString()
                          : '0') +
                      ' m'),
            ),
            Expanded(
              child: _detailsRow(
                  context,
                  _flippedTimePages,
                  (_story.flippedPages != null
                          ? _story.flippedPages.toString()
                          : '0') +
                      ' pages'),
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
        color: _story.color,
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
                valueColor: AlwaysStoppedAnimation<Color>(_story.color),
                value: _story.progress ?? 0,
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Text(
              (_story.progress != null
                      ? (_story.progress * 100).toString()
                      : '0') +
                  '%',
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
