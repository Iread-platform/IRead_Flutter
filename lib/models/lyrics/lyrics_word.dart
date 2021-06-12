import 'package:iread_flutter/models/model.dart';

class LyricsWord extends Model {
  String _word;
  int _milliseconds;

  LyricsWord({word, milliseconds})
      : _word = word,
        _milliseconds = milliseconds;

  get word => _word;
  get milliseconds => _milliseconds;
}
