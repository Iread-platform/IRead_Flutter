import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/story_bloc.dart';
import 'package:iread_flutter/bloc/story_player_bloc.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:iread_flutter/models/Data.dart';
import 'package:iread_flutter/views/Widgets/highlight_text.dart';

import 'package:provider/provider.dart';

import 'bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'models/stories_section_model.dart';
import 'models/story.dart';
import 'models/word.dart';
import 'views/Screens/story_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => StoryscreenBloc()..add(GetAudioEvent()),
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => TextSelectionProvider()),

        // ChangeNotifierProvider(create: (context) => StoryPlayerBloc()),
        ChangeNotifierProvider(create: (context) => StoryBloc()),
      ], child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  String storyString =
      '''Once upon a time there was an old mother pig who had three little pigs and not enough food to feed them. So when they were old enough, she sent them out into the world to seek their fortunes.

The first little pig was very lazy. He didn't want to work at all and he built his house out of straw. The second little pig worked a little bit harder but he was somewhat lazy too and he built his house out of sticks. Then, they sang and danced and played together the rest of the day.

The third little pig worked hard all day and built his house with bricks. It was a sturdy house complete with a fine fireplace and chimney. It looked like it could withstand the strongest winds.


 
The next day, a wolf happened to pass by the lane where the three little pigs lived; and he saw the straw house, and he smelled the pig inside. He thought the pig would make a mighty fine meal and his mouth began to water ''';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iread',
      home: Scaffold(
          body: Center(
        child: StoryScreen(
          strStory: storyString,
        ),
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
