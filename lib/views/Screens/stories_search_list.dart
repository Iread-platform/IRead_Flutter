import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/search_stories_by_tag_bloc/search_stories_by_tag.dart';
import 'package:iread_flutter/bloc/search_stories_by_tag_bloc/search_stories_by_tag_state.dart';
import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/views/widgets/shared/request_handler.dart';
import 'package:iread_flutter/views/widgets/story/stories_list.dart';

class StoriesSearchList extends StatefulWidget {
  const StoriesSearchList({Key key}) : super(key: key);

  @override
  _StoriesSearchListState createState() => _StoriesSearchListState();
}

class _StoriesSearchListState extends State<StoriesSearchList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  SearchStoriesByTagBloc _storyBloc;

  @override
  void initState() {
    super.initState();
    _storyBloc = context.read<SearchStoriesByTagBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return RequestHandler<SearchStoriesByTagState, SearchStoriesByTagBloc>(
        main: Container(
          color: Theme.of(context).colorScheme.surface,
        ),
        onSuccess: (context, data) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _init(context, data.data);
          });
          return StoriesList(
            listKey: _listKey,
            stories: _storyBloc.stories,
          );
        },
        bloc: _storyBloc);
  }

  void _init(BuildContext context, StoriesSectionModel stories) {
    AnimatedListState state = _listKey.currentState;

    state.insertItem(0, duration: Duration(milliseconds: 300));

    for (int i = 0; i < stories.stories.length; i++) {
      state.insertItem(i, duration: Duration(milliseconds: 400 + i * 100));
    }
  }
}
