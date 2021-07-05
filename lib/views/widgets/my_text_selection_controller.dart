import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/vocabulary_dialog.dart';
import 'package:provider/provider.dart';
import 'package:speech_bubble/speech_bubble.dart';

// enum _TextSelectionHandlePosition { start, end }

class MyTextSelectionControls extends TextSelectionControls {
  var marginX;
  var marginY;
  MyTextSelectionControls({this.marginX, this.marginY});
  // =============== override Cursor ================
  @override
  Widget buildHandle(BuildContext context, TextSelectionHandleType type,
      double textLineHeight) {
    return Icon(
      Icons.arrow_drop_up_rounded,
      color: Colors.purple,
      size: 50,
    );
  }

  // =============== Override Popup Menu ================

  @override
  Widget buildToolbar(
      BuildContext context,
      Rect globalEditableRegion,
      double textLineHeight,
      Offset position,
      List<TextSelectionPoint> endpoints,
      TextSelectionDelegate delegate,
      ClipboardStatusNotifier clipboardStatus,
      Offset lastSecondaryTapDownPosition) {
    return Consumer<TextSelectionProvider>(
      builder: (context, cart, child) {
        return TextSelectionToolbar(
            anchorAbove: Offset(position.dx + marginX, position.dy + marginY),
            anchorBelow: Offset(0, 0),
            toolbarBuilder: (context, _) {
              return FittedBox(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 15,
                          offset: Offset(0, 10),
                          spreadRadius: 0)
                    ],
                  ),
                  child: SpeechBubble(
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                    borderRadius: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: popupMenu(
                        context: context,
                        isWord: cart.textSelectedIsWord,
                        highlighted: cart.highlighted,
                        playButton: cart.playButton,
                      ),
                    ),
                  ),
                ),
              );

              // return (position.dy > 30 && position.dy < 250)
              //     ?
              //     : Container();
            },
            children: [Container()]);
      },
    );
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    return Offset(25, 20);
  }

  @override
  Size getHandleSize(double textLineHeight) {
    return Size(0, 0);
  }

  List<Widget> popupMenu(
      {context, bool isWord, bool highlighted, bool playButton}) {
    // If a word where selected, There will be two options: Vocabulary and highlight.
    if (isWord && !highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Shading",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          onPressed: () {},
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Vocabulary",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            return VocabularyDialog.VocDialog(context: context);
          },
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            IReadIcons.play,
            color: Colors.purple,
          ),
          onPressed: () {
            BlocProvider.of<StoryscreenBloc>(context).add(SeekToWordEvent(
                index:
                    Provider.of<TextSelectionProvider>(context, listen: false)
                        .selection
                        .start));
          },
        )
      ];
    }
    //  The clicked selection is a word: The student can delete the selection, or see the vocabulary (if any).
    else if (isWord && highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.remove_circle,
            color: Colors.purple,
            size: 25,
          ),
          onPressed: () {},
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Vocabulary",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            return VocabularyDialog.VocDialog(context: context);
          },
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            IReadIcons.play,
            color: Colors.purple,
          ),
          onPressed: () {},
        )
      ];
    }
    //If a sentence were selected , There will be one option: highlight.
    else if (!isWord && !highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Shading",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          onPressed: () {},
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            IReadIcons.play,
            color: Colors.purple,
          ),
          onPressed: () {},
        )
      ];
    }
    //  already highlighted selection : The clicked selection is a sentence The student can only delete the selection.
    else if (!isWord && highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.remove_circle,
            color: Colors.purple,
            size: 25,
          ),
          onPressed: () {},
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            IReadIcons.play,
            color: Colors.purple,
          ),
          onPressed: () {},
        )
      ];
    }
    return null;
  }
}
