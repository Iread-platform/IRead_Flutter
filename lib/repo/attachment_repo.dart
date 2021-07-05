import 'dart:io';

import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:iread_flutter/models/attachment/uploading_audio.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'package:path/path.dart';

class AttachmentRepo {
  ApiService _apiService = ApiService();
  FlutterUploader _uploader = FlutterUploader();

  final String baseUrl = 'http://46.227.254.20:5014/api/iread/attachment/add';

  /// Upload audio then store uploading data in the [UploadingFile] model.
  Future<UploadingFile> saveFile(String path, int storyId) async {
    File file = File(path);
    print('Upload a file url is $baseUrl');

    final taskId = await _uploader.enqueue(
      url: baseUrl,
      files: [
        FileItem(
            savedDir: file.parent.path,
            filename: basename(file.path),
            fieldname: 'file'),
      ],
      data: {"storyId": storyId.toString()},
      showNotification: true,
      method: UploadMethod.POST,
    );

    return UploadingFile(taskId, _uploader.result);
  }
}
