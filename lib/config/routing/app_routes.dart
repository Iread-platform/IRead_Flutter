import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/main.dart';
import 'package:iread_flutter/views/widgets/story/story_assignment_card.dart';

class AppRoutes {
  static final List<AppRoute> appRoutes = [
    // ignore: todo
    // TODO remove dummy route
    AppRoute(
      '/profileStory',
      Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
            StoryAssignmentCard(
          story: story,
        ),
      ),
    ),
  ];
}
