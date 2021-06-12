import 'story_repository.dart';
import 'user_repository.dart';

class MainRepository {
  StoryRepository storyRepository;
  UserRepository userRepository;
  MainRepository() {
    storyRepository = new StoryRepository();
    userRepository = new UserRepository();
  }
}
