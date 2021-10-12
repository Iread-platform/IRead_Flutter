import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/repo/interaction_repo.dart';
import 'package:iread_flutter/utils/data.dart';

class CommentBloc extends Bloc<BlocEvent, BlocState> {
  CommentBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    yield InitialState();
  }

  Future<Data> addCommentWord(Map map) async {
    Data data = await InteractionRepo().addCommentWord(map);
    return data;
  }

  Future<Data> removeCommentWord(int id) async {
    Data data = await InteractionRepo().removeCommentWord(id);
    return data;
  }
}
