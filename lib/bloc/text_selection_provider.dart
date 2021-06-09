import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextSelectionProvider with ChangeNotifier {
  bool textSelectedIsWord = true;
  bool highlighted = false;
  bool playButton = true;

  void changeSelection({selection, textSelected}) {
    try {
      List<String> wordSelected = textSelected.split(" ");
      print(wordSelected);
      if (wordSelected.length > 1) {
        this.textSelectedIsWord = false;
      } else {
        this.textSelectedIsWord = true;
      }
    } catch (e) {}

    notifyListeners();
  }
}
