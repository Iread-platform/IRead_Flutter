import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'package:iread_flutter/bloc/drawing_bloc/drawing_events.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:iread_flutter/config/routing/app_router.dart';
import 'package:iread_flutter/config/themes/theme.dart';
import 'package:iread_flutter/services/permissions_service.dart';
import 'package:iread_flutter/views/widgets/story/drawing_widget.dart';
import 'package:provider/provider.dart';

import 'bloc/base/base_bloc.dart';
import 'bloc/comment_bloc/comment_bloc.dart';
import 'bloc/drawing_bloc/drawing_bloc.dart';
import 'bloc/drawing_bloc/drawing_states.dart';
import 'bloc/record_bloc/record_bloc.dart';
import 'config/app_config.dart';
import 'config/http/httpOverrides.dart';
import 'config/themes/theme.dart';
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
        onGenerateRoute: AppRouter().appRouterGenerator,
        navigatorKey: AppConfigs.instance().navigationKey,
        home: Scaffold(body: IReadApp()));
  }
}

class IReadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    BlocProvider.of<StoryscreenBloc>(context, listen: false).deviceWidth = w;
    BlocProvider.of<StoryscreenBloc>(context, listen: false).deviceHight = h;
    return Scaffold(
      body: Center(
        child: MultiProvider(providers: [
          Provider(
              create: (context) =>
                  DrawingBloc(NoPolygonState())..add(FetchPolygonEvent(20))),
          Provider(create: (context) => RecordBloc(InitialState())),
          Provider(create: (context) => CommentBloc(InitialState()))
        ], child: DrawingWidget()),
      ),
    );
  }
}
