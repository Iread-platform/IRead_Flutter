import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
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
    BlocProvider.of<StoryscreenBloc>(context).init(widget.storyString);
    f();
  }

  void f() async {
    while (true) {
      await Future.delayed(Duration(milliseconds: 200));
      BlocProvider.of<StoryscreenBloc>(context)
          .add(HighlightWordEvent(index: Random().nextInt(100)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<StoryscreenBloc, StoryscreenState>(
        builder: (context, state) {
          if (state is HighLightWordState) {
            return SelectableText.rich(
              TextSpan(children: state.spans),
              selectionControls: MyTextSelectionControls(
                marginX: widget.marginX,
                marginY: widget.marginY,
              ),
              style: Theme.of(context).textTheme.headline6,
              scrollPhysics: ScrollPhysics(parent: ScrollPhysics()),
              textAlign: TextAlign.center,
              showCursor: true,
              onSelectionChanged: (selection, cause) {
                String textSelected = widget.storyString
                    .substring(selection.start, selection.end);
                Provider.of<TextSelectionProvider>(context, listen: false)
                    .changeSelection(
                        selection: selection, textSelected: textSelected);
              },
            );
          } else {
            print("els");
            return Container();
          }
        },
      ),
    );
  }
}
