import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iread_flutter/config/routing/app_router.dart';
import 'package:iread_flutter/config/themes/theme.dart';
import 'package:iread_flutter/services/permissions_service.dart';

import 'config/http/httpOverrides.dart';
import 'models/stories_section_model.dart';
import 'models/story.dart';
import 'models/user.dart';

void main() {
  // Override server certificate
  HttpOverrides.global = new IreadHttpOverrides();

  AppRouter().init().then((value) => runApp(MyApp()));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PermissionService.checkPermissions();

    return MaterialApp(
      title: 'Iread',
      theme: mainTheme,
      onGenerateRoute: AppRouter().appRouterGenerator,
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (context) => TextButton(
              child: Text("Click me !"),
              onPressed: () {
                AppRouter().navigate(context, '/story/1');
              },
            ),
          ),
        ),
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
    tags: ['Anger', 'Love', 'Feelings', 'Generous', 'Learning', 'Effective'],
    pages: 1300,
    progress: 0.45,
    flippedPages: 53,
    readingTime: 127.25);

User user =
    User(name: 'Motasem Ghozlan', imageUrl: 'https://picsum.photos/200/300');
