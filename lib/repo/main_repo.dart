import 'dart:convert';

import 'package:iread_flutter/models/attachment/attachment.dart';
import 'package:iread_flutter/models/draw/polygon.dart';
import 'package:iread_flutter/models/interaction/interaction.dart';
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
    _savePolygon(polygon, storyId);
    yield Data.fail('Fail');

    try {
      final stream = await _saveAttachment(polygon, storyId);
      stream.listen((event) {
        final res = event.response;
        final json = jsonDecode(res);

        Attachment.fromJson(json);
      });
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

  Future<Stream> _savePolygon(Polygon polygon, int storyId) async {
    String studentId;
    Interaction interaction = Interaction(studentId, 0, storyId);

    Map<String, dynamic> json = {
      "points": jsonEncode(polygon.pointsToJson()),
      "interaction": interaction,
      "audioId": 0,
      "comment": polygon.comment
    };

    print('Polygon data ${jsonEncode(json)}');
  }
}
