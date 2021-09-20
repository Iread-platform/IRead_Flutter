import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebase_base_service.dart';

enum StoryEvents {
  storyPageRead,
  storyOpen,
  storyClose,
}

class ActionTrackService extends FirebaseBaseService {
  // Events ids:
  //   Story page read event:
  static const Map<StoryEvents, String> _EVENTS = {
    StoryEvents.storyOpen: "STORY_OPEN",
    StoryEvents.storyClose: "STORY_CLOSE",
    StoryEvents.storyPageRead: "STORY_PAGE_READ",
  };

  FirebaseAnalytics analytics = FirebaseAnalytics();

  static final ActionTrackService _instance = ActionTrackService._internal();

  factory ActionTrackService() => _instance;

  ActionTrackService._internal() : super();

  Future<void> observeRoute(String name) async {
    analytics.setCurrentScreen(screenName: name);
  }

  Future<void> registerStoryPageEvent(int story, StoryEvents event,
      {int page, Map<String, Object> parameters}) async {
    parameters?.addAll({'story': story, 'page': page});
    analytics.logEvent(
        name: "${_EVENTS[event]}",
        parameters: parameters ?? {'story': story, 'page': page});
  }

  @override
  Future<void> init() async {
    analytics.setAnalyticsCollectionEnabled(true);
  }
}
