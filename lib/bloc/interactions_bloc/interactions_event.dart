part of 'interactions_bloc.dart';

@immutable
abstract class InteractionsEvent {}

class HightLightEvent extends InteractionsEvent {
  final Map map;
  HightLightEvent({this.map});
}

class RemoveHighLightEvent extends InteractionsEvent {
  final int highlightID;
  RemoveHighLightEvent({this.highlightID});
}

class VocabularyEvent extends InteractionsEvent {
  final int wordIndex;
  VocabularyEvent({this.wordIndex});
}
