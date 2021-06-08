import 'package:flutter/material.dart';
import 'package:iread_flutter/config/themes/theme.dart';
import 'package:iread_flutter/views/widgets/story/story_card.dart';
import 'package:iread_flutter/views/widgets/text_selection_provider.dart';
import 'package:provider/provider.dart';

import 'models/stories_section_model.dart';
import 'models/story.dart';

void main() {
  runApp(
    ChangeNotifierProvider<TextSelectionProvider>(
      create: (_) => TextSelectionProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iread',
      theme: mainTheme,
      home: Scaffold(
          body: ListView(
        children: [
          StoryCard(
            title: "Title",
            imageUrl:
                'https://images.unsplash.com/photo-1622983472974-4c5a568beeec?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
            color: Colors.cyan,
          ),
          StoryCard(
            title: "Title",
            imageUrl:
                'https://images.unsplash.com/photo-1623119632232-01163ce7e939?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
            color: Colors.cyan,
          ),
          StoryCard(
            title: "Title",
            imageUrl:
                'https://images.unsplash.com/photo-1623133106725-1e3d77acb7f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=80',
            color: Colors.cyan,
          ),
        ],
      )),
    );
  }
}

// ignore: todo
// TODO clear static stories
List<StoriesSectionModel> storiesSection = [
  StoriesSectionModel('Continue Reading', [story, story, story, story]),
  StoriesSectionModel('Continue Reading', [story, story, story, story]),
  StoriesSectionModel('Continue Reading', [story, story, story, story]),
  StoriesSectionModel('Continue Reading', [story, story, story, story]),
  StoriesSectionModel('Continue Reading', [story, story, story, story]),
  StoriesSectionModel('Continue Reading', [story, story, story, story]),
  StoriesSectionModel('Continue Reading', [story, story, story, story]),
];

Story story = Story(
    title: 'Wood, Wire, Wings',
    color: Colors.teal,
    imageUrl: 'https://blog-cdn.reedsy.com/uploads/2019/12/another.jpg',
    progress: 0.45,
    flippedPages: 53,
    readingTime: 127.25);
