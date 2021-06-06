import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/text_selection_provider.dart';
import 'package:provider/provider.dart';

import 'my_text_selection_controller.dart';

// ignore: must_be_immutable
class HighlighText extends StatelessWidget {
  var marginX;
  var marginY;
  HighlighText({this.marginX, this.marginY});
  List<TextSpan> getStory(context) {
    List<TextSpan> spans = [];
    String storyString =
        Provider.of<TextSelectionProvider>(context, listen: false).storyString;
    List<String> story = storyString.split(" ");
    for (var word in story) {
      spans.add(
        TextSpan(
          text: "$word ",
        ),
      );
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: marginX, vertical: marginY),
        child: SelectableText.rich(
          TextSpan(children: getStory(context)),
          selectionControls: MyTextSelectionControls(
            marginX: marginX,
            marginY: marginY,
          ),
          style: Theme.of(context).textTheme.headline6,
          scrollPhysics: ScrollPhysics(parent: ScrollPhysics()),
          textAlign: TextAlign.center,
          showCursor: true,
          onSelectionChanged: (selection, cause) {
            Provider.of<TextSelectionProvider>(context, listen: false)
                .changeSelection(selection: selection);
          },
        ),
      ),
    );
  }
}
