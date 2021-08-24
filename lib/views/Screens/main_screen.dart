import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/utils/data_generator.dart';
import 'package:iread_flutter/views/widgets/opened_library/stories_section.dart';
import 'package:iread_flutter/views/widgets/search_bar.dart';
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
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: SearchBar()),
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
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding), child: StoriesSection(
            title: "Continue reading",
            storiesList: DataGenerator.storyList(10),
            storyWidth: 100,
            horizontalPadding: 0,
          ),
        )
      ],
    );
  }
}
