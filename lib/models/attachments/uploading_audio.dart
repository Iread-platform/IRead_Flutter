import 'dart:async';

/// [UploadingAudio] represent uploading audio data
class UploadingAudio {
  final String taskId;
  final Stream stream;

  UploadingAudio(this.taskId, this.stream);
}
