import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/story/story_image.dart';

class StoryDetailsActions extends StatelessWidget {
  final Story _story;

  const StoryDetailsActions({@required Story story, Key key})
      : _story = story,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              width: 200,
              child: Column(
                children: [
                  RatingBarIndicator(
                    rating: 3.75,
                    itemCount: 5,
                    itemSize: 24,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 8),
                    itemBuilder: (BuildContext context, int index) => Icon(
                      IReadIcons.star,
                      color: Colors.amberAccent,
                    ),
                  ),
                  StoryImage(imageUrl: _story.imageUrl, color: _story.color)
                ],
              ))
        ],
      ),
    );
  }
}
