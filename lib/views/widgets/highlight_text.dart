import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:iread_flutter/models/story_page_model.dart';
import 'package:provider/provider.dart';

import 'my_text_selection_controller.dart';

// ignore: must_be_immutable
class HighlighText extends StatefulWidget {
  var marginX = 0.0;
  var marginY = 0.0;
  var storyString = "";
  List<Words> words;
  HighlighText({this.storyString, this.words, this.marginX, this.marginY});

  @override
  _HighlighTextState createState() => _HighlighTextState();
}

class _HighlighTextState extends State<HighlighText> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StoryscreenBloc>(context).init(widget.storyString);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SelectableText.rich(
        TextSpan(
          children: [
            for (int i = 0; i < widget.words.length; i++)
              TextSpan(
                  text: widget.words[i].word + " ",
                  style: BlocProvider.of<StoryscreenBloc>(context, listen: true)
                              .highLightIndex
                              .toString() ==
                          i.toString()
                      ? TextStyle(backgroundColor: Colors.purple)
                      : TextStyle())
          ],
        ),
        // autofocus: true,
        // focusNode: FocusNode(
        //   descendantsAreFocusable: true,
        //   canRequestFocus: true,
        //   debugLabel: "how",
        // ),
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
    );
  }
}
