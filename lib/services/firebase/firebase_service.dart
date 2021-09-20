import 'package:firebase_core/firebase_core.dart';
import 'action_track_service.dart';
import 'firebase_messaging.dart';

class FirebaseService {
  FirebaseMessagingService _messagingService;
  FirebaseMessagingService get messagingService => _messagingService;
  ActionTrackService _actionsTrackService;
  ActionTrackService get actionsTrackService => _actionsTrackService;
  FirebaseService() : super();

  Future<void> init() async {
    // init firebase application
    await Firebase.initializeApp();

    _messagingService = FirebaseMessagingService.instance();
    _actionsTrackService = ActionTrackService();
  }
}
