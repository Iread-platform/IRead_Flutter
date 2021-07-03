import 'package:iread_flutter/models/draw/polygon.dart';
import 'package:iread_flutter/repo/interaction_repo.dart';
import 'package:iread_flutter/repo/story_repo.dart';
import 'package:iread_flutter/utils/data.dart';

class MainRepo {
  final StoryRepo _storyRepo = StoryRepo();
  final InteractionRepo _interactionRepo = InteractionRepo();

  // Save all polygon data
  Data savePolygon(Polygon polygon) {
    return _interactionRepo.savePolygon(polygon);
  }
}
