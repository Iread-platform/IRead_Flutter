import 'dart:async';

/// [UploadingFile] represent uploading audio data
class UploadingFile {
  final String taskId;
  final Stream stream;

  UploadingFile(this.taskId, this.stream);
}
