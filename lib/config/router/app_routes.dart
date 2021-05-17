import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/story/story_card.dart';

class AppRoutes {
  static final List<AppRoute> appRoutes = [
    AppRoute(
      '/',
      Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
            StoryCard(
          color: Colors.cyan,
          title: 'Wood, Wire, Wings',
          imageUrl:
              'https://i.pinimg.com/236x/20/3b/53/203b533756c2a5efe9bafb39960b4fcb.jpg',
          progress: 0.3,
        ),
      ),
    ),
  ];
}
