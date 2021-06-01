import 'package:flutter/material.dart';
import 'package:iread_flutter/config/themes/theme.dart';
import 'package:iread_flutter/views/open_library.dart';

import 'models/stories_section_model.dart';
import 'models/story.dart';

import 'View/Screens/sutitles_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iread',
      theme: mainTheme,
      home: SubtitlesScreen(),
    );
  }
}
