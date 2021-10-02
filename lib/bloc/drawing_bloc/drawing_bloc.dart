import 'dart:developer';

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
import 'package:iread_flutter/utils/extensions.dart';

class DrawingBloc extends Bloc<BlocEvent, BlocState> {
  // ignore: todo
  // TODO replace dummy story id;
  int storyId = 1;
  MainRepo _mainRepo = MainRepo();
  List<Polygon> _polygons = [];
  List<Polygon> _polygonsToDraw = [];

  int _selectedPolygonIndex = 0;
  bool closed = false;
  RecordBloc recordBloc;
  BlocEvent lastEvent;
  bool canInteract = true;
  Color color = Colors.black87.withOpacity(0.5);
  double screenWidth;
  double screenHeight;

  DrawingBloc(BlocState initialState) : super(initialState);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is SavePolygonEvent) {
      lastEvent = event;
    } else if (event is DrawSyncEvents && selectedPolygon.saved) {
      lastEvent = event;
    }

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
        String comment = (event as CommentUpdateEvent).comment;
        // Behavior on comment add, update, and delete
        if (selectedPolygon.saved) {
          lastEvent = event;
          showSuccessToast("Syncing your comment");
          yield PolygonSavingState();
          yield await updateComment(selectedPolygon, storyId, comment);
        } else {
          if (comment.isNullOrEmpty()) {
            showSuccessToast(
                "Your comment has deleted, please click on the save button to upload your draw to the server.");
          } else {
            showSuccessToast(
                "Your comment has added, please click on the save button to upload your draw to the server.");
          }

          selectedPolygon.comment = comment;
        }
        break;
      case PolygonSyncEvent:
        yield PolygonSavingState();
        break;
      case PolygonRecordDeleteEvent:
        yield* deleteRecordFromPolygon(storyId);
        break;
      case ColorUpdateEvent:
        yield NoPolygonState();
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
    }, onError: (ex, stacktrace) {
      log("Exception $ex\n$stacktrace");
      add(FailEvent(message: "Can not save the polygon."));
      if (selectedPolygon.saved) {
        _mainRepo.deletePolygon(selectedPolygon);
      }
    });

    showSuccessToast("Syncing your draw");

    return PolygonSavingState();
  }

  void addPolygon(Polygon polygon) {
    _polygons.add(polygon);
    _polygonsToDraw.add(polygon);
  }

  void updateRecord(String path) async {
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
      }, onError: (ex, stacktrace) {
        log("exception $ex\n$stacktrace");
        add(FailEvent(message: "Can not upload your record right now"));
      });
    }
  }

  Future<PolygonDeletedState> deletePolygon() async {
    if (!selectedPolygon.saved) {
      _polygons.removeAt(_selectedPolygonIndex);
      _polygonsToDraw.removeAt(_selectedPolygonIndex);
      closed = false;
      showSuccessToast("Your draw has been deleted, you can draw another one");
      return PolygonDeletedState();
    }

    final deleteState = await _mainRepo.deletePolygon(selectedPolygon);
    // Delete associated record
    final polygonPath = selectedPolygon.localRecordPath;
    recordBloc.add(DeleteRecordEvent(polygonPath));
    // Make user able to paint
    closed = false;

    final state = PolygonDeletedState()..polygon = selectedPolygon;
    if (deleteState) {
      _polygons.removeAt(_selectedPolygonIndex);
      _polygonsToDraw.removeAt(_selectedPolygonIndex);
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

    color = polygonData.data.color;
    _polygons.add(polygonData.data);
    _polygonsToDraw.add(polygonData.data);
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

  updateComment(Polygon polygon, int storyId, String comment) async {
    if (comment == polygon.comment) {
      return PolygonSavedState(Data.success(comment));
    }
    selectedPolygon.comment = comment;
    final data = await _mainRepo.updatePolygon(polygon, storyId);

    if (data.state == DataState.Success) {
      if (comment.isNullOrEmpty()) {
        showSuccessToast("Your comment has been deleted");
      } else {
        showSuccessToast("Your comment has been added");
      }

      return PolygonSavedState(Data.success(comment));
    } else {
      return throwFailState("Can not update comment on server.");
    }
  }

  List<Polygon> get polygons => _polygonsToDraw;

  Polygon get selectedPolygon =>
      _polygons.length > 0 ? _polygons[_selectedPolygonIndex] : null;

  Polygon get selectedPolygonForDraw =>
      _polygons.length > 0 ? _polygonsToDraw[_selectedPolygonIndex] : null;

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

  Stream<BlocState> deleteRecordFromPolygon(int storyId) async* {
    showSuccessToast("Deleting the record");
    yield PolygonSavingState();

    selectedPolygon.recordSaved = false;
    selectedPolygon.localRecordPath = null;
    selectedPolygon.audioId = null;

    if (!selectedPolygon.saved) {
      showSuccessToast("The record has been deleted");
      yield PolygonSavedState(Data.success(true));
    }

    final data = await _mainRepo.updatePolygon(selectedPolygon, storyId);

    if (data.state == DataState.Success) {
      showSuccessToast("The record has been deleted");
      yield PolygonSavedState(data);
    } else {
      yield throwFailState("Can not delete the record right now.");
    }
  }

  void changeColor(Color value) {
    color = value;
    add(ColorUpdateEvent());
  }
}
