import 'package:iread_flutter/bloc/base/base_bloc.dart';

class CommentEvents extends BlocEvent {
  final int _polygonIndex;

  CommentEvents(this._polygonIndex);

  get polygonIndex => _polygonIndex;
}

class AddCommentEvent extends CommentEvents {
  String _comment;

  AddCommentEvent(int polygonIndex, this._comment) : super(polygonIndex);

  get comment => _comment;
}

class DeleteCommentEvent extends CommentEvents {
  DeleteCommentEvent(int polygonIndex) : super(polygonIndex);
}
