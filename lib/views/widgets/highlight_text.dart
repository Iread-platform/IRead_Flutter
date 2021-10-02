import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:iread_flutter/models/story_model.dart';
import 'package:provider/provider.dart';

import 'my_text_selection_controller.dart';

// ignore: must_be_immutable
class HighlighText extends StatefulWidget {
  var marginX = 0.0;
  var marginY = 0.0;
  var storyString = "";
  List<Word> words;
  GlobalKey globalKey = GlobalKey();
  HighlighText({this.storyString, this.words, this.marginX, this.marginY});

  @override
  _HighlighTextState createState() => _HighlighTextState();
}

class _HighlighTextState extends State<HighlighText> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StoryscreenBloc>(context, listen: false)
        .init(widget.storyString);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: Provider.of<TextSelectionProvider>(context, listen: false)
          .scrollController,
      child: SelectableText.rich(
        TextSpan(
          children: [
            for (int i = 0; i < widget.words.length; i++)
              TextSpan(
                text: widget.words[i].content + " ",
                style: BlocProvider.of<StoryscreenBloc>(context, listen: false)
                            .highLightIndex
                            .toString() ==
                        i.toString()
                    ? TextStyle(
                        fontSize: 40,
                        backgroundColor: Colors.red,
                        color: Colors.white)
                    : TextStyle(
                        fontSize: 40,
                        backgroundColor: widget.words[i].isHighLighted
                            ? Colors.yellow
                            : Colors.transparent,
                        decoration: widget.words[i].isComment
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationStyle: TextDecorationStyle.dashed,
                        decorationColor: Colors.orange
                      ),
              )
          ],
        ),
        selectionControls: MyTextSelectionControls(
          marginX: widget.marginX,
          marginY: widget.marginY,
        ),
        style: Theme.of(context).textTheme.headline6,
        // scrollPhysics: ScrollPhysics(parent: ScrollPhysics()),
        textAlign: TextAlign.center,
        showCursor: true,
        onSelectionChanged: (selection, cause) {
          try {
            BlocProvider.of<StoryscreenBloc>(context).add(PauseEvent());

            String textSelected =
                widget.storyString.substring(selection.start, selection.end);
            // ================ on word click =>> seek to word ===============
            // if (cause == SelectionChangedCause.longPress) {
            //   BlocProvider.of<StoryscreenBloc>(context).add(PauseEvent());
            // } else {
            //   BlocProvider.of<StoryscreenBloc>(context)
            //       .add(SeekToWordEvent(index: selection.start));
            // }
            //===============================================================
            Provider.of<TextSelectionProvider>(context, listen: false)
                .changeSelection(
                    selection: selection, textSelected: textSelected);
          } catch (e) {
            print("onSelectionChanged EXCEPTION ");
          }
        },
      ),
    );
  }
}
