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
    try {
      await _interactionRepo.savePolygon(polygon, storyId);

      if (polygon.localRecordPath != null) {
        final stream = await _saveAttachment(polygon, storyId);
        await for (final snapshot in stream) {}
      }
    } catch (e) {
      Data.handleException(e);
    }
  }

  // Store file then return stream
  Future<Stream> _saveAttachment(Polygon polygon, int storyId) async {
    final uploadingFileData =
        await _attachmentRepo.saveFile(polygon.localRecordPath, storyId);
    // Handle upload result
    return uploadingFileData.stream;
  }
}
