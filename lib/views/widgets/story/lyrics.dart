import 'package:flutter/material.dart';
import 'package:iread_flutter/models/lyrics/lyrics_word.dart';

class Lyrics extends StatefulWidget {
  final List<LyricsWord> _lyricsWord;

  Lyrics({@required lyricsWord}) : _lyricsWord = lyricsWord;

  @override
  _LyricsState createState() => _LyricsState();
}

class _LyricsState extends State<Lyrics> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
