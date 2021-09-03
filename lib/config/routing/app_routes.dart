import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/search_stories_by_tag_bloc/search_stories_by_tag.dart';
import 'package:iread_flutter/bloc/search_stories_by_tag_bloc/search_stories_by_tag_event.dart';
import 'package:iread_flutter/bloc/story/story_details_bloc/story_details_bloc.dart';
import 'package:iread_flutter/bloc/story/story_details_bloc/story_details_events.dart';
import 'package:iread_flutter/models/user/user.dart';
import 'package:iread_flutter/services/auth_service.dart';
import 'package:iread_flutter/utils/data_generator.dart';
import 'package:iread_flutter/views/Screens/login_screen.dart';
import 'package:iread_flutter/views/Screens/stories_search_list.dart';
import 'package:iread_flutter/views/Screens/story_details.dart';
import 'package:iread_flutter/views/widgets/story/story_assignment_card.dart';

class AppRoutes {
  static final List<AppRoute> appRoutes = [
    // TODO remove dummy route
    AppRoute(
      '/profileStory',
      Handler(
          handlerFunc:
              (BuildContext context, Map<String, List<String>> params) =>
                  // Example on route handler guard
                  _routeAuthHandler(
                    context,
                    StoryAssignmentCard(
                      story: DataGenerator.story(),
                    ),
                  )),
    ),
    AppRoute(
        '/searchByTag/:tag',
        Handler(
            handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
                BlocProvider(
                  create: (_) => SearchStoriesByTagBloc(LoadingState())
                    ..add(SearchStoriesByTagEvent(params['tag'][0])),
                  child: Container(
                      color: Theme.of(context).colorScheme.surface,
                      child: StoriesSearchList()),
                ))),
    AppRoute('/story/:id ', Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      print(params);
      var id = params.entries.elementAt(0).value[0];
      return BlocProvider(
        create: (context) => StoryDetailsBloc(InitialState())
          ..add(FetchStoryDetailsEvent(int.parse(id))),
        child: Container(
            color: Theme.of(context).colorScheme.surface,
            child: StoryDetails()),
      );
    }))
  ];

  static Widget _routeAuthHandler(BuildContext context, Widget defaultPage,
      {Widget onAdmin, Widget onTeacher, Widget onStudent, Widget onNoUser}) {
    print("=============================");
    print(AuthService().cU);
    return StreamBuilder<User>(
        stream: AuthService().currentUserStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.userRole) {
              case UserRole.Admin:
                return onAdmin ?? defaultPage;
              case UserRole.Teacher:
                return onTeacher ?? defaultPage;
              case UserRole.Student:
                return onStudent ?? defaultPage;
              default:
                return defaultPage;
            }
          } else {
            return onNoUser ?? LoginScreen();
          }
        });
  }
}
