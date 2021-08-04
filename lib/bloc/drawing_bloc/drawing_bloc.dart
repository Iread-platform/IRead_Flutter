import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/drawing_bloc/drawing_events.dart';
import 'package:iread_flutter/bloc/drawing_bloc/drawing_states.dart';
import 'package:iread_flutter/models/attachment/attachment.dart';
import 'package:iread_flutter/models/draw/polygon.dart';
import 'package:iread_flutter/repo/main_repo.dart';
import 'package:iread_flutter/utils/data.dart';

class DrawingBloc extends Bloc<BlocEvent, BlocState> {
  // TODO replace dummy story id;
  int storyId = 4;
  MainRepo _mainRepo = MainRepo();
  List<Polygon> _polygons = [];
  int _selectedPolygonIndex = 0;

  DrawingBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    print('event is ${event.runtimeType}');
    yield LoadingState();

    switch (event.runtimeType) {
      case SavePolygonEvent:
        yield _savePolygon(selectedPolygon);
        break;
      case RecordSavedEvent:
        yield PolygonRecordSaved();
        break;
      case PolygonSavedEvent:
        yield PolygonSavedState(Data.success(true));
        break;
      case DeletePolygonEvent:
        yield PolygonDeletingState();
        yield await deletePolygon();
        break;
    }
  }

  PolygonSavingState _savePolygon(Polygon polygon) {
    Stream saveStream = _mainRepo.savePolygon(polygon, storyId);
    saveStream.listen((item) {
      if (item.data is Polygon) {
        selectedPolygon.id = item.data.id;
      }
      if (item.data is Attachment) {
        add(RecordSavedEvent());
      } else {
        selectedPolygon.saved = true;
        add(PolygonSavedEvent());
      }
    });

    return PolygonSavingState();
  }

  void addPolygon(Polygon polygon) => _polygons.add(polygon);

  Future<PolygonDeletedState> deletePolygon() async {
    if (!selectedPolygon.saved) {
      return PolygonDeletedState(true);
    }

    final deleteState = await _mainRepo.deletePolygon(selectedPolygon);

    if (deleteState) {
      _polygons.removeAt(_selectedPolygonIndex);
    }

    return PolygonDeletedState(deleteState);
  }

  List<Polygon> get polygons => _polygons;

  Polygon get selectedPolygon =>
      _polygons.length > 0 ? _polygons[_selectedPolygonIndex] : null;

  get selectedPolygonIndex => _selectedPolygonIndex;
}
