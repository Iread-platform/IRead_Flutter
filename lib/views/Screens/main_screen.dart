import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/main_screen/main_screen_bloc.dart';
import 'package:iread_flutter/models/stories_section_model.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/utils/data_generator.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/input/auto_complete_search_field.dart';
import 'package:iread_flutter/views/widgets/opened_library/stories_section.dart';
import 'package:iread_flutter/views/widgets/shared/app_bar.dart';
import 'package:iread_flutter/views/widgets/shared/request_handler.dart';

class MainScreen extends StatelessWidget {
  // ignore: unused_field
  final double _horizontalPadding;
  const MainScreen({double horizontalPadding, Key key})
      : _horizontalPadding = horizontalPadding ?? 12,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RequestHandler<SuccessState, MainScreenBloc>(
      onSuccess: (context, state) {
        final storiesSections = state.data as List<StoriesSectionModel>;
        return ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            IreadAppBar(),
            Container(
                margin: const EdgeInsets.only(bottom: 12, right: 12, left: 12),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  shadowColor: Color(0XAA7A07BB),
                  elevation: 2,
                  child: AutoCompleteTextField<Story>(
                    label: 'Search a story',
                    itemView: (Story story) => story.title,
                    inputDecoration: _inputDecoration(context),
                    onResultSelected: (Story story) {},
                    onSearchTextChanges: (term) {
                      final c = Completer<List<Story>>()
                        ..complete(DataGenerator.storyList(10));
                      return c.future;
                    },
                  ),
                )),
            SizedBox(
              height: 12,
            )
          ]..addAll(_buildStoriesSections(context, storiesSections)),
        );
      },
      main: Container(),
    );
  }

  _inputDecoration(BuildContext context) => InputDecoration(
        contentPadding: EdgeInsets.all(10),
        border: _inputBorder(Colors.transparent, 0),
        enabledBorder: _inputBorder(Colors.transparent, 0),
        focusedBorder: _inputBorder(Theme.of(context).colorScheme.primary, 0),
        errorBorder: _inputBorder(Colors.red, 0),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        focusColor: Theme.of(context).colorScheme.secondary,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Icon(
            IReadIcons.search,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        hintText: "story section",
      );

  _inputBorder(Color color, double width) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide:
            BorderSide(width: width ?? 0, color: color ?? Colors.transparent),
      );

  List<Widget> _buildStoriesSections(
      BuildContext context, List<StoriesSectionModel> storiesSections) {
    List<Widget> widgets = [];

    for (final section in storiesSections) {
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: StoriesSection(
          title: section.title,
          storiesList: section.stories,
          storyWidth: 100,
          sectionHeight: 300,
        ),
      ));

      widgets.add(SizedBox(
        height: 25,
      ));
    }

    widgets.removeLast();
    return widgets;
  }
}
