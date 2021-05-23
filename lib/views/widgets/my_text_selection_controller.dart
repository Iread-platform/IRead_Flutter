import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iread_flutter/views/widgets/text_selection_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_bubble/speech_bubble.dart';

class MyTextSelectionControls extends TextSelectionControls {
  @override
  Widget buildHandle(BuildContext context, TextSelectionHandleType type,
      double textLineHeight) {
    return Icon(
      Icons.star_outlined,
      color: Colors.purple,
      size: 30,
    );
  }

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
          anchorAbove: Offset(position.dx + 10, position.dy + 140),
          anchorBelow: Offset(position.dx + 10, -140),
          toolbarBuilder: (context, child) {
            return SpeechBubble(
              color: Colors.white,
              child: child,
            );
          },
          children: popupMenu(
              isWord: cart.textSelectedIsWord, highlighted: cart.highlighted),
        );
      },
    );
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    return Offset(1, 1);
  }

  @override
  Size getHandleSize(double textLineHeight) {
    return Size(textLineHeight, textLineHeight);
  }

  List<Widget> popupMenu({bool isWord, bool highlighted}) {
    // If a word where selected, There will be two options: Vocabulary and highlight.
    if (isWord && !highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.all(10),
          child: Text("highlight"),
          onPressed: () {},
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.all(10),
          child: Text("Vocabulary"),
          onPressed: () {},
        ),
      ];
    }
    //  The clicked selection is a word: The student can delete the selection, or see the vocabulary (if any).
    else if (isWord && highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Icon(
            Icons.remove_circle,
            color: Colors.purple,
            size: 30,
          ),
          onPressed: () {},
        )
      ];
    }
    //If a sentence were selected(more than one word), There will be one option: highlight.
    else if (!isWord && !highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.all(10),
          child: Text("highlight"),
          onPressed: () {},
        ),
      ];
    }
    //  already highlighted selection : The clicked selection is a sentence The student can only delete the selection.
    else if (!isWord && highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Icon(
            Icons.remove_circle,
            color: Colors.purple,
            size: 30,
          ),
          onPressed: () {},
        )
      ];
    }
    return null;
  }
}
