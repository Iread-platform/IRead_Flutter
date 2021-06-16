import 'package:flutter/cupertino.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/models/stories_section_model.dart';

class SearchStoriesByTagState extends SuccessState<StoriesSectionModel> {
  SearchStoriesByTagState({@required data}) {
    this.data = data;
    state = DataState.Success;
  }

  get storiesSection => data;
}
