import 'package:flutter/cupertino.dart';
import 'package:iread_flutter/services/firebase/action_track_service.dart';

mixin ActionTrackerMixin<T extends StatefulWidget> on State<T> {
  /// Story id
  int story();
  DateTime start;
  DateTime end;
  @override
  void initState() {
    start = DateTime.now();
    ActionTrackService().registerStoryPageEvent(story(), StoryEvents.storyOpen);
    super.initState();
  }

  @override
  void dispose() {
    end = DateTime.now();

    ActionTrackService().registerStoryPageEvent(story(), StoryEvents.storyClose,
        parameters: {"duration": end.difference(start).inSeconds});
    super.dispose();
  }
}
