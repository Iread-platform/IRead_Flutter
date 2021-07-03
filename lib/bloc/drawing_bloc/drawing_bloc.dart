import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/drawing_bloc/drawing_events.dart';
import 'package:iread_flutter/bloc/drawing_bloc/drawing_states.dart';
import 'package:iread_flutter/models/draw/polygon.dart';
import 'package:iread_flutter/repo/main_repo.dart';
import 'package:iread_flutter/utils/data.dart';

class DrawingBloc extends Bloc<BlocEvent, BlocState> {
  MainRepo _mainRepo = MainRepo();
  List<Polygon> _polygons = [];
  int _selectedPolygonIndex = 0;

  DrawingBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    yield LoadingState();

    switch (event.runtimeType) {
      case SavePolygonEvent:
        yield _savePolygon(selectedPolygon);
    }
  }

  PolygonSavedState _savePolygon(Polygon polygon) {
    Data data = _mainRepo.savePolygon(polygon);
    selectedPolygon.saved = true;
    return PolygonSavedState(data);
  }

  void addPolygon(Polygon polygon) => _polygons.add(polygon);

  void deletePolygon(int index) {
    _polygons.removeAt(index);
  }

  List<Polygon> get polygons => _polygons;
  Polygon get selectedPolygon => _polygons[_selectedPolygonIndex];
  get selectedPolygonIndex => _selectedPolygonIndex;
}
