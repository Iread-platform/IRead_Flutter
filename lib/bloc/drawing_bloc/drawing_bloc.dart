import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/models/draw/polygon.dart';

class DrawingBloc extends Bloc<BlocEvent, BlocState> {
  List<Polygon> _polygons = [];
  int _selectedPolygonIndex = 0;

  DrawingBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

  addPolygon(Polygon polygon) => _polygons.add(polygon);

  deletePolygon(int index) {
    _polygons.removeAt(index);
  }

  get polygons => _polygons;
  get selectedPolygon => _polygons[_selectedPolygonIndex];
}
