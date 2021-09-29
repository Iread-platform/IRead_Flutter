import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/models/stories_section_model.dart';

class MainScreenBlocState extends BlocState {}

class MainScreenDataFetchedState extends SuccessState {
  MainScreenDataFetchedState({List<StoriesSectionModel> storiesSections})
      : super(data: storiesSections);
}
