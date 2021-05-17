import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HighlighText extends StatefulWidget {
  @override
  _HighlighTextState createState() => _HighlighTextState();
}

class _HighlighTextState extends State<HighlighText> {
  bool selected = false;
  int s = -1;
  int e = -1;
  List wordListSelected = [];
  bool isWord = false;
  List<String> highlight = [];
  String storyString = "hello how are you i am fine how";
  List<String> story;
  List<TextSpan> getStory() {
    List<TextSpan> spans = [];
    story = storyString.split(" ");
    for (var word in story) {
      if (highlight.contains("$word")) {
        spans.add(
          TextSpan(
            text: "$word ",
            style: TextStyle(backgroundColor: Colors.pink),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: "$word ",
          ),
        );
      }
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        selected
            ? Container(
                height: 70,
                width: w * 0.6,
                margin: EdgeInsets.all(20),
                child: Card(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text("Highlight"),
                      onPressed: () {
                        setState(() {
                          selected = false;
                          for (var word in wordListSelected) {
                            highlight.add(word);
                          }
                        });
                      },
                    ),
                    isWord
                        ? ElevatedButton(
                            child: Text("Vocabulary"),
                            onPressed: () {
                              setState(() {
                                selected = false;
                              });
                            },
                          )
                        : Text("")
                  ],
                )),
              )
            : Container(
                height: 70,
                margin: EdgeInsets.all(20),
              ),
        Center(
          child: SelectableText.rich(
            TextSpan(children: getStory()),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            toolbarOptions: ToolbarOptions(
              copy: false,
              paste: false,
              cut: false,
              selectAll: false,
            ),
            onSelectionChanged: (selection, cause) {
              setState(() {
                selected = !selection.isCollapsed;
                try {
                  String temp =
                      storyString.substring(selection.start, selection.end);

                  wordListSelected = temp.split(" ");
                  print(wordListSelected);
                  if (wordListSelected.length > 1) {
                    isWord = false;
                  } else {
                    isWord = true;
                    s = selection.start;
                    e = selection.end;
                  }
                } catch (e) {}
              });
            },
          ),
        ),
      ],
    );
  }
}
