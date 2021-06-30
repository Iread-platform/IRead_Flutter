import 'package:iread_flutter/bloc/base/base_bloc.dart';

abstract class CommentStates extends BlocState {}

class AddCommentState extends CommentStates {
  String _comment;

  AddCommentState(this._comment);
}
