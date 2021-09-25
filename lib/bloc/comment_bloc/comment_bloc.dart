import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/repo/interaction_repo.dart';

class CommentBloc extends Bloc<BlocEvent, BlocState> {
  CommentBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    yield InitialState();
  }

  Future<int> addCommentWord(Map map) async {
    int data = await InteractionRepo().addCommentWord(map);
    print(data);
    return data;
  }

  Future<int> removeCommentWord(int id) async {
    int data = await InteractionRepo().removeCommentWord(id);
    return data;
  }
}
