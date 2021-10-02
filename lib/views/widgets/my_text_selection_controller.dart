import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'package:iread_flutter/bloc/interactions_bloc/interactions_bloc.dart';
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
        double x = 0;
        try {
          x = Provider.of<TextSelectionProvider>(context, listen: false)
              .scrollController
              .offset;
          print("xxxxxxxxxxxx : $x");
        } catch (e) {}

        return TextSelectionToolbar(
            anchorAbove:
                Offset(position.dx + marginX, position.dy + marginY - x),
            anchorBelow: Offset(-140, -140),
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
                        delegate: delegate,
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
              // : Container();
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
      {context,
      bool isWord,
      bool highlighted,
      bool playButton,
      TextSelectionDelegate delegate}) {
    // If a word where selected, There will be two options: Vocabulary and highlight.
    if (isWord && !highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.remove_circle,
            color: Colors.purple,
            size: 25,
          ),
          onPressed: () {
            removeHighlightWord(context);
            BlocProvider.of<StoryscreenBloc>(context).add(ResumeEvent());

            delegate.hideToolbar();
          },
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Shading",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          onPressed: () async {
            Map map = {
              "interaction": {
                "storyId": 23,
                "studentId": "d6d896bd-6d99-41ca-bd9f-3bf3a29db7f7",
                "pageId": BlocProvider.of<StoryscreenBloc>(context)
                    .storyPageData
                    .data
                    .pages[BlocProvider.of<StoryscreenBloc>(context)
                        .pageController
                        .page
                        .toInt()]
                    .pageId
              },
              "firstWordIndex":
                  Provider.of<TextSelectionProvider>(context, listen: false)
                      .selection
                      .start,
              "endWordIndex":
                  Provider.of<TextSelectionProvider>(context, listen: false)
                      .selection
                      .end,
              "firstWord": "Bright",
              "endWord": "Charlotte"
            };
            int highLightID = await BlocProvider.of<InteractionsBloc>(context)
                .addHightLightWord(map);

            for (var word in BlocProvider.of<StoryscreenBloc>(context)
                .storyPageData
                .data
                .pages[BlocProvider.of<StoryscreenBloc>(context)
                    .pageController
                    .page
                    .toInt()]
                .words) {
              if ((word.startIndex >=
                      Provider.of<TextSelectionProvider>(context, listen: false)
                          .selection
                          .start) &&
                  (word.startIndex <=
                      Provider.of<TextSelectionProvider>(context, listen: false)
                          .selection
                          .end)) {
                word.isHighLighted = true;
                word.highLightID = highLightID;
              }
            }

            delegate.hideToolbar();
            BlocProvider.of<StoryscreenBloc>(context).add(ResumeEvent());
          },
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Vocabulary",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            delegate.hideToolbar();
            return VocabularyDialog.vocDialog(context: context);
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
            delegate.hideToolbar();
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
          onPressed: () {
            removeHighlightWord(context);
            BlocProvider.of<StoryscreenBloc>(context).add(ResumeEvent());

            delegate.hideToolbar();
          },
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Vocabulary",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            delegate.hideToolbar();
            return VocabularyDialog.vocDialog(context: context);
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
            delegate.hideToolbar();
          },
        )
      ];
    }
    //If a sentence were selected , There will be one option: highlight.
    else if (!isWord && !highlighted) {
      return [
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.remove_circle,
            color: Colors.purple,
            size: 25,
          ),
          onPressed: () {
            removeHighlightWord(context);
            BlocProvider.of<StoryscreenBloc>(context).add(ResumeEvent());

            delegate.hideToolbar();
          },
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Shading",
            style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
          ),
          onPressed: () async {
            Map map = {
              "interaction": {
                "storyId": 23,
                "studentId": "d6d896bd-6d99-41ca-bd9f-3bf3a29db7f7",
                "pageId": BlocProvider.of<StoryscreenBloc>(context)
                    .storyPageData
                    .data
                    .pages[BlocProvider.of<StoryscreenBloc>(context)
                        .pageController
                        .page
                        .toInt()]
                    .pageId
              },
              "firstWordIndex":
                  Provider.of<TextSelectionProvider>(context, listen: false)
                      .selection
                      .start,
              "endWordIndex":
                  Provider.of<TextSelectionProvider>(context, listen: false)
                      .selection
                      .end,
              "firstWord": "Bright",
              "endWord": "Charlotte"
            };
            int highLightID = await BlocProvider.of<InteractionsBloc>(context)
                .addHightLightWord(map);

            for (var word in BlocProvider.of<StoryscreenBloc>(context)
                .storyPageData
                .data
                .pages[BlocProvider.of<StoryscreenBloc>(context)
                    .pageController
                    .page
                    .toInt()]
                .words) {
              if ((word.startIndex >=
                      Provider.of<TextSelectionProvider>(context, listen: false)
                          .selection
                          .start) &&
                  (word.startIndex <=
                      Provider.of<TextSelectionProvider>(context, listen: false)
                          .selection
                          .end)) {
                word.isHighLighted = true;
                word.highLightID = highLightID;
              }
            }

            delegate.hideToolbar();
            BlocProvider.of<StoryscreenBloc>(context).add(ResumeEvent());
          },
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            IReadIcons.play,
            color: Colors.purple,
          ),
          onPressed: () {
            print(Provider.of<TextSelectionProvider>(context, listen: false)
                .selection
                .start);
            BlocProvider.of<StoryscreenBloc>(context).add(SeekToWordEvent(
                index:
                    Provider.of<TextSelectionProvider>(context, listen: false)
                        .selection
                        .start));
            delegate.hideToolbar();
          },
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
          onPressed: () {
            removeHighlightWord(context);
            BlocProvider.of<StoryscreenBloc>(context).add(ResumeEvent());

            delegate.hideToolbar();
          },
        ),
        TextSelectionToolbarTextButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            IReadIcons.play,
            color: Colors.purple,
          ),
          onPressed: () {
            print(Provider.of<TextSelectionProvider>(context, listen: false)
                .selection
                .start);
            BlocProvider.of<StoryscreenBloc>(context).add(SeekToWordEvent(
                index:
                    Provider.of<TextSelectionProvider>(context, listen: false)
                        .selection
                        .start));
            delegate.hideToolbar();
          },
        )
      ];
    }
    return null;
  }

  removeHighlightWord(context) {
    int start = Provider.of<TextSelectionProvider>(context, listen: false)
        .selection
        .start;
    int end = Provider.of<TextSelectionProvider>(context, listen: false)
        .selection
        .end;
    int id = -2;
    for (var word in BlocProvider.of<StoryscreenBloc>(context)
        .storyPageData
        .data
        .pages[BlocProvider.of<StoryscreenBloc>(context)
            .pageController
            .page
            .toInt()]
        .words) {
      if (word.isHighLighted &&
          word.startIndex >= start &&
          word.startIndex <= end) {
        BlocProvider.of<InteractionsBloc>(context)
            .removeHighLightWord(word.highLightID);
        id = word.highLightID;
        break;
      }
    }
    for (var word in BlocProvider.of<StoryscreenBloc>(context)
        .storyPageData
        .data
        .pages[BlocProvider.of<StoryscreenBloc>(context)
            .pageController
            .page
            .toInt()]
        .words) {
      if (word.highLightID == id) {
        word.highLightID = -1;
        word.isHighLighted = false;
      }
    }
  }
}
