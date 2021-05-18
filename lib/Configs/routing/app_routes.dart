import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/story/profile_story_card.dart';

class AppRoutes {
  static final List<AppRoute> appRoutes = [
    // TODO remove dummy route
    AppRoute(
      '/profileStory',
      Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
            ProfileStoryCard(
          imageUrl:
              'https://i.pinimg.com/236x/20/3b/53/203b533756c2a5efe9bafb39960b4fcb.jpg',
          color: Colors.amber,
          title: 'Title',
          readingTime: 24.0,
          flippedPages: 3,
          progress: 0.3,
        ),
      ),
    ),
  ];
}
