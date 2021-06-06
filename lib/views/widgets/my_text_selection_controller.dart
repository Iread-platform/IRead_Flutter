import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iread_flutter/views/widgets/text_selection_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_bubble/speech_bubble.dart';

class MyTextSelectionControls extends TextSelectionControls {
  var marginX;
  var marginY;
  MyTextSelectionControls({this.marginX, this.marginY});
  List<Widget> popupMenu({bool isWord, bool highlighted}) {
    // If a word where selected, There will be two options: Vocabulary and highlight.
    if (isWord && !highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Shading",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          onPressed: () {},
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Vocabulary",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          onPressed: () {},
        ),
      ];
    }
    //  The clicked selection is a word: The student can delete the selection, or see the vocabulary (if any).
    else if (isWord && highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Icon(
            Icons.remove_circle,
            color: Colors.purple,
            size: 25,
          ),
          onPressed: () {},
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Vocabulary",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          onPressed: () {},
        ),
      ];
    }
    //If a sentence were selected , There will be one option: highlight.
    else if (!isWord && !highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            "Shading",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          onPressed: () {},
        ),
      ];
    }
    //  already highlighted selection : The clicked selection is a sentence The student can only delete the selection.
    else if (!isWord && highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Icon(
            Icons.remove_circle,
            color: Colors.purple,
            size: 25,
          ),
          onPressed: () {},
        )
      ];
    }
    return null;
  }

  // =============== override Cursor ================
  @override
  Widget buildHandle(BuildContext context, TextSelectionHandleType type,
      double textLineHeight) {
    return Icon(
      Icons.star_outlined,
      color: Colors.purple,
      size: 30,
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
            anchorBelow: Offset(position.dx + 10, -140),
            toolbarBuilder: (context, _) {
              return Container(
                width: 180,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 15,
                          offset: Offset(0, 10),
                          spreadRadius: 0)
                    ]),
                child: SpeechBubble(
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                    borderRadius: 40,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: popupMenu(
                            isWord: cart.textSelectedIsWord,
                            highlighted: false))),
              );
            },
            children: [Container()]);
      },
    );
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    return Offset(15, 10);
  }

  @override
  Size getHandleSize(double textLineHeight) {
    return Size(textLineHeight, textLineHeight);
  }
}
