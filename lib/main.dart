import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:iread_flutter/config/routing/app_router.dart';
import 'package:iread_flutter/config/themes/theme.dart';
import 'package:iread_flutter/services/permissions_service.dart';
import 'package:iread_flutter/views/Screens/story_screen.dart';
import 'package:iread_flutter/views/widgets/vocabulary_dialog.dart';
import 'package:provider/provider.dart';

import 'config/http/httpOverrides.dart';
import 'models/stories_section_model.dart';
import 'models/story.dart';
import 'models/user.dart';

void main() {
  // Override server certificate
  HttpOverrides.global = new IreadHttpOverrides();

  AppRouter().init().then(
        (value) => runApp(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => StoryscreenBloc(),
              ),
            ],
            child: ChangeNotifierProvider(
              create: (context) => TextSelectionProvider(),
              child: MyApp(),
            ),
          ),
        ),
      );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PermissionService.checkPermissions();

    return MaterialApp(
      theme: mainTheme,
      title: 'Iread',
      home: IReadApp(),
    );
  }
}

class IReadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    BlocProvider.of<StoryscreenBloc>(context, listen: false).deviceWidth = w;
    BlocProvider.of<StoryscreenBloc>(context, listen: false).deviceHight = h;
    print(w);
    return Scaffold(
      body: Center(
        child: StoryScreen(),
      ),
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
    color: Colors.black38,
    imageUrl: 'https://picsum.photos/200/300',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sit amet lacus tincidunt, consequat lorem ac, consectetur ligula. Sed non nunc vehicula, pretium arcu a, faucibus eros. Cras lacinia magna sed enim malesuada finibus. Nulla et varius neque. Etiam dolor erat, dictum sodales facilisis ac, cursus vehicula lacus. Vestibulum et ante lorem. Pellentesque pretium arcu felis, nec efficitur lacus ultricies quis. Morbi eu tortor facilisis, porta elit quis, varius diam.',
    writer: 'Motasem Ghozlan',
    pages: 1300,
    progress: 0.45,
    flippedPages: 53,
    readingTime: 127.25);

User user =
    User(name: 'Motasem Ghozlan', imageUrl: 'https://picsum.photos/200/300');
