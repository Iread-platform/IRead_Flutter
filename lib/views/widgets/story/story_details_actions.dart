import 'package:flutter/material.dart';
import 'package:iread_flutter/config/routing/app_router.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/review/rating_bar.dart';
import 'package:iread_flutter/views/widgets/story/story_image.dart';

class StoryDetailsActions extends StatelessWidget {
  final Story _story;
  final _buttons = ['listening', 'reading', 'a challenge'];

  StoryDetailsActions({@required Story story, Key key})
      : _story = story,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              child: Row(
            children: [
              Container(
                width: 150,
                child: Column(
                  children: [
                    RatingBar(
                        rating: _story.rating == null ? 0 : _story.rating),
                    StoryImage(
                        imageUrl: _story.storyCover?.downloadUrl == null
                            ? ''
                            : _story.storyCover?.downloadUrl,
                        color: _story.color)
                  ],
                ),
              ),
            ],
          )),
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: _elevatedButton(context, _buttons[0], () {
                    AppRouter().navigate(context, '/storyscreen/${_story.id}');
                  }),
                ),
                SizedBox(
                  height: 12,
                ),
                _elevatedButton(context, _buttons[1], () {}),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: _elevatedButton(context, _buttons[2], () {}),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _elevatedButton(
          BuildContext context, String title, Function onPressed) =>
      Container(
        width: 125,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Theme.of(context).colorScheme.surface),
          ),
          style: _elevatedButtonStyle(context),
        ),
      );

  ButtonStyle _elevatedButtonStyle(BuildContext context) =>
      ElevatedButton.styleFrom(
          primary: _story.color,
          onPrimary: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(storyBorderRadius)));
}
