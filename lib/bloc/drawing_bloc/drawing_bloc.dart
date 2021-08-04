import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/drawing_bloc/drawing_events.dart';
import 'package:iread_flutter/bloc/drawing_bloc/drawing_states.dart';
import 'package:iread_flutter/bloc/record_bloc/record_bloc.dart';
import 'package:iread_flutter/bloc/record_bloc/record_events.dart';
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
  bool closed = false;
  RecordBloc recordBloc;

  DrawingBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    switch (event.runtimeType) {
      case FetchPolygonEvent:
        yield LoadingState();
        yield await fetchPolygon((event as FetchPolygonEvent).id);
        break;
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
      case FailEvent:
        yield FailState(message: (event as FailEvent).message);
        break;
    }
  }

  PolygonSavingState _savePolygon(Polygon polygon) {
    Stream saveStream = _mainRepo.savePolygon(polygon, storyId);
    saveStream.listen((item) {
      if (item.state == DataState.Fail) {
        add(FailEvent(message: item.message));
      }
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
    // Delete associated record
    final polygonPath = selectedPolygon.localRecordPath;
    recordBloc.add(DeleteRecordEvent(polygonPath));
    // Make user able to paint
    closed = false;

    final state = PolygonDeletedState(deleteState)..polygon = selectedPolygon;
    if (deleteState) {
      _polygons.removeAt(_selectedPolygonIndex);
    }

    return state;
  }

  Future<BlocState> fetchPolygon(int id) async {
    final polygonData = await _mainRepo.fetchPolygon(id);

    if (polygonData.state == DataState.Fail) {
      return FailState(message: polygonData.message);
    }
    // Close draw area
    closed = true;

    _polygons.add(polygonData.data);
    _selectedPolygonIndex = 0;
    return DrawPolygonState();
  }

  List<Polygon> get polygons => _polygons;

  Polygon get selectedPolygon =>
      _polygons.length > 0 ? _polygons[_selectedPolygonIndex] : null;

  get selectedPolygonIndex => _selectedPolygonIndex;
}
