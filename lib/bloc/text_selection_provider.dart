import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextSelectionProvider with ChangeNotifier {
  bool textSelectedIsWord = true;
  bool highlighted = false;
  bool playButton = true;
  ScrollController scrollController = new ScrollController();

  TextSelection selection;
  String wordSelection = "";
  void changeSelection({selection, textSelected}) {
    // scrollController.animateTo(scrollController.offset.,
    //     duration: Duration(milliseconds: 1000), curve: Curves.linear);
    this.selection = selection;
    try {
      List<String> wordSelected = textSelected.split(" ");
      if (wordSelected.length > 1) {
        this.textSelectedIsWord = false;
      } else {
        this.textSelectedIsWord = true;
        wordSelection = wordSelected[0];
      }
    } catch (e) {}

    notifyListeners();
  }
}
