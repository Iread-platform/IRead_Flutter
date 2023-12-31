import 'dart:io';

import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:iread_flutter/models/attachment/uploading_audio.dart';
import 'package:path/path.dart';

class AttachmentRepo {
  FlutterUploader _uploader = FlutterUploader();

  final String baseUrl = 'http://217.182.250.236:5014/api/iread/Attachment/add';
  final String avatarAddEndPoint =
      'http://217.182.250.236:5014/api/iread/Attachment/add';

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

  Future<UploadingFile> uploadAvatar(
      File file, String title, String gender) async {
    print('Upload a file url is $avatarAddEndPoint');

    final taskId = await _uploader.enqueue(
      url: avatarAddEndPoint,
      files: [
        FileItem(
            savedDir: file.parent.path,
            filename: basename(file.path),
            fieldname: 'file'),
      ],
      data: {"title": title, "gender": gender},
      showNotification: true,
      method: UploadMethod.POST,
    );

    return UploadingFile(taskId, _uploader.result);
  }
}
