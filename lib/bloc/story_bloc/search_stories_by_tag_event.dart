import 'package:iread_flutter/bloc/base/base_bloc.dart';

class SearchStoriesByTagEvent extends BlocEvent {
  final String _title;
  SearchStoriesByTagEvent(this._title);

  get title => _title;
}
