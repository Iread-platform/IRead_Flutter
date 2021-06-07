import 'package:flutter/material.dart';
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
        children: [
          Container(
              child: Row(
            children: [
              Container(
                width: 150,
                child: Column(
                  children: [
                    RatingBar(rating: 3.75),
                    StoryImage(imageUrl: _story.imageUrl, color: _story.color)
                  ],
                ),
              ),
            ],
          )),
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _elevatedButton(context, _buttons[0], () {}),
              ),
              _elevatedButton(context, _buttons[1], () {}),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _elevatedButton(context, _buttons[2], () {}),
              )
            ],
          ))
        ],
      ),
    );
  }

  ElevatedButton _elevatedButton(
          BuildContext context, String title, Function onPressed) =>
      ElevatedButton(
        onPressed: onPressed,
        child: Text(
          _buttons[0],
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Theme.of(context).colorScheme.surface),
        ),
        style: _elevatedButtonStyle(context),
      );

  ButtonStyle _elevatedButtonStyle(BuildContext context) =>
      ElevatedButton.styleFrom(
          primary: _story.color,
          onPrimary: Theme.of(context).colorScheme.surface);
}
