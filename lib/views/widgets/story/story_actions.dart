import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/story/story_image.dart';

class StoryActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                StoryImage(
                    color: Colors.redAccent,
                    imageUrl:
                        'https://images.unsplash.com/photo-1519074069444-1ba4fff66d16?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80')
              ],
            ),
          )
        ],
      ),
    );
  }
}
