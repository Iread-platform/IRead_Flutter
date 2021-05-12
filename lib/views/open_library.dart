import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';
import 'package:iread_flutter/views/widgets/opened_library/stories_section.dart';

class OpenLibrary extends StatelessWidget {
  final _storyWidth = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            StoriesSection(
              title: 'Continue Reading',
              storiesList: [
                story,
                story,
                story,
                story,
                story,
                story,
                story,
              ],
              storyWidth: _storyWidth,
            ),
            SizedBox(
              height: 32,
            ),
            StoriesSection(
              title: 'Continue Reading',
              storiesList: [story, story, story],
              storyWidth: _storyWidth,
            ),
          ],
        ),
      ),
    );
  }
}

Story story = Story(
    title: 'Wood, Wire, Wings',
    color: Colors.teal,
    imageUrl: 'https://blog-cdn.reedsy.com/uploads/2019/12/another.jpg',
    progress: 0.45,
    flippedPages: 53,
    readingTime: 127.25);
