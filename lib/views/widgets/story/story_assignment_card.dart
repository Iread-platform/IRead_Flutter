import 'package:flutter/material.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';
import 'package:iread_flutter/config/themes/shadows.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/story/story_details_card_template.dart';
import 'package:iread_flutter/views/widgets/user/avatar.dart';

class StoryAssignmentCard extends StatelessWidget {
  final Story _story;

  const StoryAssignmentCard({Story story, Key key})
      : _story = story,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final lowerSectionColor =
        _story.color == Theme.of(context).colorScheme.surface
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface;

    return StoryDetailsCard(
      story: _story,
      upperSection: _upperSection(context),
      lowerSection: _lowerSection(context, lowerSectionColor),
    );
  }

  Widget _upperSection(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(smallBorderRadius),
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [mediumBottomRightShadow]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Assignment',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  'End date',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  'Assignment Status',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ],
        ),
      );

  Widget _lowerSection(BuildContext context, Color color) => Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(smallBorderRadius),
            color: _story.color,
            boxShadow: [mediumBottomRightShadow]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserAvatar(
                radius: 18.0,
                imageUrl:
                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'),
            SizedBox(
              width: 4,
            ),
            Text(
              'user name',
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(color: color),
            ),
            SizedBox(
              width: 12,
            ),
            Icon(
              Icons.filter_none_rounded,
              color: color,
              size: 20,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '2',
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(color: color),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.attach_file_rounded,
              color: color,
              size: 20,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '4',
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(color: color),
            )
          ],
        ),
      );
}
