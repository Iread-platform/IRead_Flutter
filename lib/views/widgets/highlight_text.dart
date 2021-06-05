import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/text_selection_provider.dart';
import 'package:provider/provider.dart';

import 'my_text_selection_controller.dart';

class HighlighText extends StatelessWidget {
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
    var h = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 140),
        height: h,
        child: SelectableText.rich(
          TextSpan(children: getStory(context)),
          selectionControls: MyTextSelectionControls(),
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
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
