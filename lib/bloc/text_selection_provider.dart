import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextSelectionProvider with ChangeNotifier {
  bool textSelectedIsWord = true;
  bool highlighted = false;
  bool playButton = true;
  ScrollController scrollController = new ScrollController();
  
  TextSelection selection;
  void changeSelection({selection, textSelected}) {
    this.selection = selection;
    try {
      List<String> wordSelected = textSelected.split(" ");
      if (wordSelected.length > 1) {
        this.textSelectedIsWord = false;
      } else {
        this.textSelectedIsWord = true;
      }
    } catch (e) {}

    notifyListeners();
  }
}
