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
            imageUrl: 'https://picsum.photos/200/300',
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
    imageUrl: 'https://picsum.photos/200/300',
    progress: 0.45,
    flippedPages: 53,
    readingTime: 127.25);
