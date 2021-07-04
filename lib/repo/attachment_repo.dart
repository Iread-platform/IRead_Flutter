import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:iread_flutter/models/attachments/uploadingAudio.dart';
import 'package:iread_flutter/services/api_service.dart';
import 'package:iread_flutter/utils/data.dart';

class AttachmentRepo {
  ApiService _apiService = ApiService();
  FlutterUploader _uploader = FlutterUploader();

  final String baseUrl = 'attachment';

  Future<Data<UploadingAudio>> saveAudio(String path) async {
    final taskId = await _uploader.enqueue(url: '$baseUrl', files: [
      FileItem(savedDir: '$path', filename: '$path', fieldname: 'file')
    ]);

    return Data<UploadingAudio>.success(
        UploadingAudio(taskId, _uploader.result));
  }
}
