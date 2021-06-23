import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/models/draw/polygon.dart';

class DrawingBloc extends Bloc<BlocEvent, BlocState> {
  List<Polygon> _polygons = [];
  final recorder = FlutterAudioRecorder("record.mp4");

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
}
