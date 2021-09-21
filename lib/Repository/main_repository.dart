import 'story_repository.dart';

class MainRepository {
  StoryRepository storyRepository;
  MainRepository() {
    storyRepository = new StoryRepository();
  }
}
