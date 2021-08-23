import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/search_bar.dart';
import 'package:iread_flutter/views/widgets/shared/app_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IreadAppBar(),
        Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: SearchBar()),
      ],
    );
  }
}
