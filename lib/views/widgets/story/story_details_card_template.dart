import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/layout/responsive_layout_builder.dart';
import 'package:iread_flutter/views/widgets/story/story_image.dart';

class StoryDetailsCard extends StatelessWidget {
  final Story _story;
  final Widget _upperSection;
  final Widget _lowerSection;

  const StoryDetailsCard(
      {@required Story story,
      @required Widget upperSection,
      @required Widget lowerSection,
      Key key})
      : _story = story,
        _upperSection = upperSection,
        _lowerSection = lowerSection,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        alignment: Alignment.centerRight,
        clipBehavior: Clip.none,
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
                  child: StoryImage(
                      imageUrl: _story.imageUrl, color: _story.color)),
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
                  onXSm: (context) => _upperSection,
                )),
            Expanded(flex: 1, child: _lowerSection),
          ],
        ),
      );
}
