import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/highlight_text.dart';
import 'package:iread_flutter/views/widgets/story/story_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: HighlighText(),
      ),
    );
  }
}
