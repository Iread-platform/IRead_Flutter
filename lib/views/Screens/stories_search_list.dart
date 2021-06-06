import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iread_flutter/config/themes/border_radius.dart';
import 'package:iread_flutter/config/themes/shadows.dart';
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(storyBorderRadius),
                    boxShadow: [mediumBottomRightShadow]),
                child: Text(
                  _storiesSection.title,
                  style: Theme.of(context).textTheme.headline2,
                ),
              )
            ],
          ),
          Column()
        ],
      ),
    );
  }
}
