import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/search_stories_by_tag_bloc/search_stories_by_tag.dart';
import 'package:iread_flutter/bloc/search_stories_by_tag_bloc/search_stories_by_tag_event.dart';
import 'package:iread_flutter/bloc/story/story_details_bloc/story_details_bloc.dart';
import 'package:iread_flutter/main.dart';
import 'package:iread_flutter/views/Screens/stories_search_list.dart';
import 'package:iread_flutter/views/widgets/story/story_assignment_card.dart';

class AppRoutes {
  static final List<AppRoute> appRoutes = [
    // ignore: todo
    // TODO remove dummy route
    AppRoute(
      '/profileStory',
      Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
            StoryAssignmentCard(
          story: story,
        ),
      ),
    ),
    AppRoute(
        '/searchByTag/:tag',
        Handler(
            handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
                BlocProvider(
                  create: (_) => SearchStoriesByTagBloc(LoadingState())
                    ..add(SearchStoriesByTagEvent(params['tag'][0])),
                  child: StoriesSearchList(),
                ))),
    AppRoute(
        '/story/:id ',
        Handler(
            handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
                BlocProvider(
                    create: (context) =>
                        StoryDetailsBloc(InitialState()).add(LoadingS))))
  ];
}
