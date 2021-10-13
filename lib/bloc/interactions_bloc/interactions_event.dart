part of 'interactions_bloc.dart';

@immutable
abstract class InteractionsEvent {}

// ignore: must_be_immutable
class HightLightEvent extends InteractionsEvent {
  Map map;
  HightLightEvent({this.map});
}

// ignore: must_be_immutable
class RemoveHighLightEvent extends InteractionsEvent {
  int highlightID;
  RemoveHighLightEvent({this.highlightID});
}

class VocabularyEvent extends InteractionsEvent {
  final int wordIndex;
  VocabularyEvent({this.wordIndex});
}

/*
{
  "commentType": "string",
  "value": "string",
  "interaction": {
    "storyId": 0,
    "studentId": "string",
    "pageId": 0
  },
  "wordTimesTamp": "string",
  "word": "string"
}
*/
