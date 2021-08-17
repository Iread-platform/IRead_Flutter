import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<Map<String, dynamic>> readAssetJson(String assetFile) async {
    String contents = await rootBundle.loadString(assetFile);

    var result = jsonDecode(contents) as Map;

    return result;
  }

  static Future<bool> checkIfFileExist(String path) async {
    final basePath = await localPath;

    final file = File(path);
    return await file.exists();
  }

  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
