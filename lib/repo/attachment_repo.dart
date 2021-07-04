import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:iread_flutter/models/attachments/uploading_audio.dart';
import 'package:iread_flutter/services/api_service.dart';

class AttachmentRepo {
  ApiService _apiService = ApiService();
  FlutterUploader _uploader = FlutterUploader();

  final String baseUrl = 'attachment';

  /// Upload audio then store uploading data in the [UploadingFile] model.
  Future<UploadingFile> saveFile(String path, int storyId) async {
    final taskId = await _uploader.enqueue(
        url: '$baseUrl',
        files: [
          FileItem(savedDir: '$path', filename: '$path', fieldname: 'file'),
        ],
        data: {"storyId": storyId.toString()},
        showNotification: true,
        method: UploadMethod.POST);

    return UploadingFile(taskId, _uploader.result);
  }
}
