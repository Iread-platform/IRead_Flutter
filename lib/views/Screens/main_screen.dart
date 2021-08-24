import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/utils/data_generator.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/input/auto_complete_search_field.dart';
import 'package:iread_flutter/views/widgets/opened_library/stories_section.dart';
import 'package:iread_flutter/views/widgets/shared/app_bar.dart';

class MainScreen extends StatelessWidget {
  final double _horizontalPadding;
  const MainScreen({double horizontalPadding, Key key})
      : _horizontalPadding = horizontalPadding ?? 12,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        IreadAppBar(),
        Container(
            child: AutoCompleteTextField<Story>(
          label: 'Search a story',
          itemView: (Story story) => story.title,
          inputDecoration: _inputDecoration(context),
          onSearchTextChanges: (term) {
            final c = Completer<List<Story>>()
              ..complete(DataGenerator.storyList(10));
            return c.future;
          },
        )),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: StoriesSection(
            title: "Continue reading",
            storiesList: DataGenerator.storyList(10),
            storyWidth: 100,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: StoriesSection(
            title: "Continue reading",
            storiesList: DataGenerator.storyList(10),
            storyWidth: 100,
            horizontalPadding: 0,
          ),
        )
      ],
    );
  }

  _inputDecoration(BuildContext context) => InputDecoration(
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
}
