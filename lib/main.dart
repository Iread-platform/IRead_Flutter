import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:provider/provider.dart';
import 'bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'models/stories_section_model.dart';
import 'models/story.dart';
import 'models/user.dart';
import 'views/Screens/story_screen.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => StoryscreenBloc(),
      )
    ],
    child: MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => TextSelectionProvider()),
    ], child: MyApp()),
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Iread',
      home: Scaffold(
        body: Center(
          child: StoryScreen(),
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





// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

// void main() => runApp(new MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => new MyAppState();
// }

// class MyAppState extends State<MyApp> {
//   GlobalKey<State> key = new GlobalKey();

//   double fabOpacity = 1.0;

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//         appBar: new AppBar(
//           title: new Text("Scrolling."),
//         ),
//         body: NotificationListener<ScrollNotification>(
//           child: new ListView(
//             itemExtent: 200.0,
//             children: [
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               new MyObservableWidget(key: key),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder(),
//               ContainerWithBorder()
//             ],
//           ),
//           onNotification: (ScrollNotification scroll) {
//             var currentContext = key.currentContext;
//             if (currentContext == null) return false;

//             var renderObject = currentContext.findRenderObject();
//             RenderAbstractViewport viewport = RenderAbstractViewport.of(renderObject);
//             var offsetToRevealBottom = viewport.getOffsetToReveal(renderObject, 1.0);
//             var offsetToRevealTop = viewport.getOffsetToReveal(renderObject, 0.0);

//             if (offsetToRevealBottom.offset > scroll.metrics.pixels ||
//                 scroll.metrics.pixels > offsetToRevealTop.offset) {
//               if (fabOpacity != 0.0) {
//                 setState(() {
//                   fabOpacity = 0.0;
//                 });
//               }
//             } else {
//               if (fabOpacity == 0.0) {
//                 setState(() {
//                   fabOpacity = 1.0;
//                 });
//               }
//             }
//             return false;
//           },
//         ),
//         floatingActionButton: new Opacity(
//           opacity: fabOpacity,
//           child: new FloatingActionButton(
//             onPressed: () {
//               print("YAY");
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyObservableWidget extends StatefulWidget {
//   const MyObservableWidget({Key key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => new MyObservableWidgetState();
// }

// class MyObservableWidgetState extends State<MyObservableWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return new Container(height: 100.0, color: Colors.green);
//   }
// }

// class ContainerWithBorder extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       decoration: new BoxDecoration(border: new Border.all(), color: Colors.grey),
//     );
//   }
// }