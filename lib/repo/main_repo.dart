import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:iread_flutter/models/draw/polygon.dart';
import 'package:iread_flutter/repo/attachment_repo.dart';
import 'package:iread_flutter/repo/interaction_repo.dart';
import 'package:iread_flutter/repo/story_repo.dart';
import 'package:iread_flutter/utils/data.dart';

class MainRepo {
  // main repo as a singleton
  static final MainRepo _instance = MainRepo._internal();
  factory MainRepo() => _instance;
  MainRepo._internal();

  final StoryRepo _storyRepo = StoryRepo();
  final InteractionRepo _interactionRepo = InteractionRepo();
  final AttachmentRepo _attachmentRepo = AttachmentRepo();

  /// Save a polygon with attachments.
  Stream<Data> savePolygon(Polygon polygon, int storyId) async* {
    final uploadingFileData =
        await _attachmentRepo.saveFile(polygon.localRecordPath, storyId);
    // Handle upload result
    uploadingFileData.stream.listen((result) {
      UploadTaskResponse response = result;

      print('File upload result is ${response.response}');
    });

    try {} catch (e) {
      Data.handleException(e);
    }
  }
}
