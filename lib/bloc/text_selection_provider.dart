import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class TextSelectionProvider with ChangeNotifier {
  bool textSelectedIsWord = true;
  bool highlighted = false;
  bool playButton = true;
  ScrollController scrollController = new ScrollController();
  StreamController<TextSelection> _textSelectionStreamController =
      BehaviorSubject<TextSelection>();
  StreamController<String> _selectedTextStreamController =
      BehaviorSubject<String>();

  Stream<String> get selectedTextStream => _selectedTextStreamController.stream;
  Stream<TextSelection> get textSelectionStream =>
      _textSelectionStreamController.stream;

  TextSelection selection;
  void changeSelection({TextSelection selection, textSelected}) {
    this.selection = selection;
    if (selection != null) {
      _textSelectionStreamController.sink.add(selection);
    }
    if (textSelected != null) {
      _selectedTextStreamController.sink.add(textSelected);
    }
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

  @override
  void dispose() {
    _selectedTextStreamController.close();
    _textSelectionStreamController.close();
    super.dispose();
  }
}
