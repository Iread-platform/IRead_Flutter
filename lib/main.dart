import 'dart:io';

import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'package:iread_flutter/bloc/login_bloc/login_bloc.dart';
import 'package:iread_flutter/bloc/main_screen/main_screen_bloc.dart';
import 'package:iread_flutter/bloc/main_screen/main_screen_bloc_events.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:iread_flutter/config/routing/app_router.dart';
import 'package:iread_flutter/config/themes/theme.dart';
import 'package:iread_flutter/services/firebase/action_track_service.dart';
import 'package:iread_flutter/services/auth_service.dart';
import 'package:iread_flutter/services/firebase/index.dart';
import 'package:iread_flutter/services/notifications_manager_service.dart';
import 'package:iread_flutter/services/permissions_service.dart';
import 'package:iread_flutter/views/Screens/login_screen.dart';
import 'package:iread_flutter/views/Screens/main_screen.dart';
import 'package:iread_flutter/views/Screens/story_screen.dart';
import 'package:iread_flutter/views/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

import 'bloc/base/base_bloc.dart';
import 'bloc/comment_bloc/comment_bloc.dart';
import 'bloc/drawing_bloc/drawing_bloc.dart';
import 'bloc/drawing_bloc/drawing_states.dart';
import 'bloc/interactions_bloc/interactions_bloc.dart';
import 'bloc/record_bloc/record_bloc.dart';
import 'config/app_config.dart';
import 'config/http/httpOverrides.dart';
import 'config/themes/theme.dart';

Future<void> initApp() async {
  await AppRouter().init();
  await FirebaseService().init();
  await NotificationsManagerService.instance().init();
  await AuthService().loadUser();
}

void main() {
  // Override server certificate
  HttpOverrides.global = new IreadHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  initApp().then(
    (value) => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => StoryscreenBloc(),
          ),
          BlocProvider(
            create: (context) => InteractionsBloc(),
          ),
          BlocProvider(
            create: (context) => CommentBloc(InitialState()),
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
    AppConfigs.instance().appContext = context;
    PermissionService.checkPermissions();

    return MaterialApp(
        theme: mainTheme,
        title: 'Iread',
        onGenerateRoute: AppRouter().appRouterGenerator,
        navigatorKey: AppConfigs.instance().navigationKey,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: ActionTrackService().analytics),
        ],
        home: (AuthService().cU != null)
            ? Scaffold(body: IReadApp())
            : BlocProvider(
                create: (context) => LoginBloc(InitialState()),
                child: LoginScreen()));
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
        drawer: DrawerWidget(),
        body: Center(
          child: MultiProvider(providers: [
            Provider(
              create: (context) => MainScreenBloc(InitialState())
                ..add(FetchMainScreenDataEvent()),
            ),
            Provider(create: (context) => DrawingBloc(NoPolygonState())),
            Provider(create: (context) => RecordBloc(InitialState())),
            Provider(create: (context) => CommentBloc(InitialState()))
          ], child: StoryScreen(storyId: 23,)),
        ));
  }
}
