import 'package:flutter/material.dart';
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StoryCard(
            color: Colors.blue[300],
            title: 'Wood, Wire, Wings',
            imageUrl:
                'https://i.pinimg.com/236x/20/3b/53/203b533756c2a5efe9bafb39960b4fcb.jpg',
            progress: 0.3,
          ),
        ),
      ),
    );
  }
}
