import 'package:iread_flutter/models/lyrics/lyrics_word.dart';
import 'package:iread_flutter/utils/file_utils.dart';

class StoryPlayerBloc {
  static Future<List<LyricsWord>> readLyricsFile(String path) async {
    final json = await FileUtils.readAssetJson(path);

    return _jsonToLyricsList(json);
  }

  static List<LyricsWord> _jsonToLyricsList(Map<String, dynamic> json) {
    List<LyricsWord> lyricsList = [];
    json = json['lyrics'];

    for (int i = 0; i < json.length; i++) {
      LyricsWord lyricsWord = LyricsWord(
          word: json[i]['word'], milliseconds: json[i]['milliseconds']);

      lyricsList.add(lyricsWord);
    }

    return lyricsList;
  }
}
