part of 'interactions_bloc.dart';

@immutable
abstract class InteractionsState {}

class InteractionsInitial extends InteractionsState {}

class LoadingState extends InteractionsState {}

class DoneState extends InteractionsState {}
