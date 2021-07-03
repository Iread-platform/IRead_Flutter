import 'package:iread_flutter/repo/interaction_repo.dart';
import 'package:iread_flutter/repo/story_repo.dart';

class MainRepo {
  final StoryRepo _storyRepo = StoryRepo();
  final InteractionRepo _interactionRepo = InteractionRepo();
}
