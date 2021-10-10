import 'dart:convert';
import 'dart:io';

import 'package:iread_flutter/models/attachment/attachment.dart';
import 'package:iread_flutter/models/draw/polygon.dart';
import 'package:iread_flutter/models/review/review_submit.dart';
import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/models/user/profile.dart';
import 'package:iread_flutter/repo/attachment_repo.dart';
import 'package:iread_flutter/repo/interaction_repo.dart';
import 'package:iread_flutter/repo/review_repo.dart';
import 'package:iread_flutter/repo/story_repo.dart';
import 'package:iread_flutter/repo/user_repo.dart';
import 'package:iread_flutter/utils/data.dart';

class MainRepo {
  // main repo as a singleton
  static final MainRepo _instance = MainRepo._internal();
  factory MainRepo() => _instance;
  MainRepo._internal();

  final InteractionRepo _interactionRepo = InteractionRepo();
  final AttachmentRepo _attachmentRepo = AttachmentRepo();
  final UserRepo _userRepo = UserRepo();
  final StoryRepo _storyRepo = StoryRepo();
  final ReviewRepo _reviewRepo = ReviewRepo();

  /// Save a polygon with attachments.
  Stream<Data> savePolygon(Polygon polygon, int storyId) async* {
    final polygonResponse =
        await _interactionRepo.savePolygon(polygon, storyId);

    yield polygonResponse;

    if (polygonResponse.state == DataState.Success) {
      polygon.id = polygonResponse.data.id;
      yield* savePolygonRecord(polygon, storyId);
    }
  }

  Stream<Data> savePolygonRecord(Polygon polygon, int storyId) async* {
    if (polygon.localRecordPath != null) {
      final stream = await _saveAttachment(polygon, storyId);
      await for (final snapshot in stream) {
        final response = jsonDecode(snapshot.response);
        Attachment attachment = Attachment.fromJson(response);
        yield Data.success(attachment);
        polygon.audioId = attachment.id;
        Data<bool> updateResult =
            await _interactionRepo.updatePolygon(polygon, storyId);

        yield updateResult;
        break;
      }
    }
  }

  Future<bool> deletePolygon(Polygon polygon) async {
    final data = await _interactionRepo.deletePolygon(polygon);

    return data.data;
  }

  Future<Data<Polygon>> fetchPolygon(int id) {
    return _interactionRepo.fetchPolygon(id);
  }

  Future<Data<bool>> updatePolygon(Polygon polygon, int storyId) async {
    return await _interactionRepo.updatePolygon(polygon, storyId);
  }

  // Store file then return stream
  Future<Stream> _saveAttachment(Polygon polygon, int storyId) async {
    final uploadingFileData =
        await _attachmentRepo.saveFile(polygon.localRecordPath, storyId);

    return uploadingFileData.stream;
  }

  Future<Data<List<StoriesSectionModel>>> fetchMainScreenData() {
    return _storyRepo.fetchMainScreenData();
  }

  Future<Data<Profile>> fetchUserProfile() async {
    return await _userRepo.fetchProfile();
  }

  Future<Data<List<Attachment>>> fetchUserAvatars() {
    return _userRepo.fetchUserAvatars();
  }

  Future<Data> updateAvatar(int id, {bool isPersonal = false}) {
    return _userRepo.updateUserAvatar(id, isPersonal: isPersonal);
  }

  Stream<Data> uploadUserAvatar(File file) async* {
    final uploadTask =
        await _attachmentRepo.uploadAvatar(file, file.path, "Male");

    await for (final snapshot in uploadTask.stream) {
      final response = jsonDecode(snapshot.response);
      print(response);
      Attachment attachment = Attachment.fromJson(response);
      yield Data.success(attachment);
      yield await updateAvatar(attachment.id, isPersonal: true);
    }
  }

  Future<Data> submitReview(ReviewSubmit reviewSubmit) {
    return _reviewRepo.submitReview(reviewSubmit);
  }
}
