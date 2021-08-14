import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/drawing_bloc/drawing_events.dart';
import 'package:iread_flutter/bloc/drawing_bloc/drawing_states.dart';
import 'package:iread_flutter/bloc/record_bloc/record_bloc.dart';
import 'package:iread_flutter/bloc/record_bloc/record_events.dart';
import 'package:iread_flutter/config/app_config.dart';
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
        showSuccessToast("Getting your draw ^_^");
        yield LoadingState();
        yield await fetchPolygon((event as FetchPolygonEvent).id);
        break;
      case SavePolygonEvent:
        yield _savePolygon(selectedPolygon);
        break;
      case RecordSavedEvent:
        showSuccessToast("Your record has been stored");
        yield PolygonRecordSaved();
        break;
      case PolygonSavedEvent:
        showSuccessToast("Your draw has been saved");
        yield PolygonSavedState(Data.success(true));
        break;
      case DeletePolygonEvent:
        showSuccessToast("Deleting your draw");
        yield PolygonDeletingState();
        yield await deletePolygon();
        break;
      case FailEvent:
        yield throwFailState((event as FailEvent).message);
        break;
      case RecordUpdateEvent:
        updateRecord((event as RecordUpdateEvent).path);
        break;
      case CommentUpdateEvent:
        // Behavior on comment add, update, and delete
        if (selectedPolygon.saved) {
          showSuccessToast("Syncing your comment");
          yield PolygonSavingState();
          yield await updateComment(
              selectedPolygon, storyId, (event as CommentUpdateEvent).comment);
        } else {
          showSuccessToast(
              "Your comment has added, please click on the save button to sync your changes with the server.");
          selectedPolygon.comment = (event as CommentUpdateEvent).comment;
        }
        break;
      case PolygonSyncEvent:
        yield PolygonSavingState();
        break;
    }
  }

  PolygonSavingState _savePolygon(Polygon polygon) {
    Stream saveStream = _mainRepo.savePolygon(polygon, storyId);
    saveStream.listen((item) {
      if (item.state == DataState.Fail) {
        add(FailEvent(message: item.message));
      } else if (item.data is Polygon) {
        selectedPolygon.id = item.data.id;
        if (polygon.localRecordPath == null) {
          selectedPolygon.saved = true;
          add(PolygonSavedEvent());
        }
      } else if (item.data is Attachment) {
        add(RecordSavedEvent());
      } else {
        selectedPolygon.saved = true;
        add(PolygonSavedEvent());
      }
    });

    showSuccessToast("Syncing your draw");

    return PolygonSavingState();
  }

  void addPolygon(Polygon polygon) => _polygons.add(polygon);

  void updateRecord(String path) {
    showSuccessToast("Your record has been saved locally");
    selectedPolygon.recordSaved = true;
    selectedPolygon.localRecordPath = path;

    if (selectedPolygon.saved) {
      add(PolygonSyncEvent());
      _mainRepo.savePolygonRecord(selectedPolygon, storyId).listen((event) {
        if (event.data is Attachment) {
          add(RecordSavedEvent());
        } else {
          selectedPolygon.saved = true;
          add(PolygonSavedEvent());
        }
      });
    }
  }

  Future<PolygonDeletedState> deletePolygon() async {
    if (!selectedPolygon.saved) {
      _polygons.removeAt(_selectedPolygonIndex);
      closed = false;
      showSuccessToast("Your draw has been deleted, you can draw another one");
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
      return throwFailState(polygonData.message);
    }
    // Close draw area
    closed = true;

    _polygons.add(polygonData.data);
    _selectedPolygonIndex = 0;
    return DrawPolygonState();
  }

  Future<BlocState> updatePolygon(Polygon polygon, int storyId) async {
    add(PolygonSyncEvent());
    final data = await _mainRepo.updatePolygon(polygon, storyId);

    if (data.state == DataState.Success) {
      showSuccessToast("Your draw has been updated");
      return PolygonSavedState(data);
    } else {
      return throwFailState(data.message);
    }
  }

  updateComment(Polygon polygon, int storyId, comment) async {
    if (comment == polygon.comment) {
      return PolygonSavedState(Data.success(comment));
    }
    selectedPolygon.comment = comment;
    final data = await _mainRepo.updatePolygon(polygon, storyId);

    if (data.state == DataState.Success) {
      showSuccessToast("Your comment has been added");
      return PolygonSavedState(Data.success(comment));
    } else {
      return throwFailState("Can not update comment on server.");
    }
  }

  List<Polygon> get polygons => _polygons;

  Polygon get selectedPolygon =>
      _polygons.length > 0 ? _polygons[_selectedPolygonIndex] : null;

  get selectedPolygonIndex => _selectedPolygonIndex;

  throwFailState(String message) {
    Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);

    return PolygonFailState();
  }

  showSuccessToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        fontSize: 16.0,
        textColor: Theme.of(AppConfigs.instance().navigationKey.currentContext)
            .colorScheme
            .primaryVariant);
  }
}
