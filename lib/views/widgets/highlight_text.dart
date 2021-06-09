import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/bloc/story_bloc.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:provider/provider.dart';

import 'my_text_selection_controller.dart';

// ignore: must_be_immutable
class HighlighText extends StatefulWidget {
  var marginX = 0.0;
  var marginY = 0.0;
  var storyString = "";
  HighlighText({this.storyString, this.marginX, this.marginY});

  @override
  _HighlighTextState createState() => _HighlighTextState();
}

class _HighlighTextState extends State<HighlighText> {
  @override
  void initState() {
    super.initState();
    Provider.of<StoryBloc>(context, listen: false).init(widget.storyString);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SelectableText.rich(
          TextSpan(
              children: Provider.of<StoryBloc>(context, listen: false)
                  .getStory(context)),
          selectionControls: MyTextSelectionControls(
            marginX: widget.marginX,
            marginY: widget.marginY,
          ),
          style: Theme.of(context).textTheme.headline6,
          scrollPhysics: ScrollPhysics(parent: ScrollPhysics()),
          textAlign: TextAlign.center,
          showCursor: true,
          onSelectionChanged: (selection, cause) {
            String textSelected =
                widget.storyString.substring(selection.start, selection.end);
            Provider.of<TextSelectionProvider>(context, listen: false)
                .changeSelection(
                    selection: selection, textSelected: textSelected);
          },
        ),
      ),
    );
  }
}
