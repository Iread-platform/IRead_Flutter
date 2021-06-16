import 'package:iread_flutter/bloc/base/base_bloc.dart';

class SearchByTagEvent extends BlocEvent {
  final String _title;
  SearchByTagEvent(this._title);

  get title => _title;
}
