import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class StoryBloc extends ChangeNotifier {
  String storyString;
  int index;
  List<TextSpan> spans = [];
  List<TextStyle> styles = [];
  List<String> wordsStory;
  void init(String story) {
    storyString = story;
    wordsStory = storyString.split(" ");
  }

  List<TextSpan> getStory(context) {
    for (int i = 0; i < wordsStory.length; i++) {
      styles.add(TextStyle());
      spans.add(
        TextSpan(
          style: styles[i],
          text: wordsStory[i] + " ",
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              print("Word : ${wordsStory[i]} , i : $i");
              index = i;
              styles[i] = TextStyle(color: Colors.red);
              notifyListeners();
            },
        ),
      );
    }
    return spans;
  }
}
