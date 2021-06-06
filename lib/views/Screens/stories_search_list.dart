import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/models/stories_section_model.dart';

class StoriesSearchList extends StatelessWidget {
  final StoriesSectionModel _storiesSection;

  const StoriesSearchList(
      {@required StoriesSectionModel storiesSection, Key key})
      : _storiesSection = storiesSection,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _storiesSection.title,
                style: Theme.of(context).textTheme.headline2,
              )
            ],
          ),
          Column()
        ],
      ),
    );
  }
}
