part of 'interactions_bloc.dart';

@immutable
abstract class InteractionsEvent {}

class HightLightEvent extends InteractionsEvent {
  int wordIndex;
  HightLightEvent({this.wordIndex});
}

class VocabularyEvent extends InteractionsEvent {
  int wordIndex;
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
