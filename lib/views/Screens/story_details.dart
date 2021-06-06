import 'package:flutter/material.dart';
import 'package:iread_flutter/views/widgets/story/story_image.dart';

class StoryDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoryImage(
        imageUrl: 'https://i.pinimg.com/564x/14/9f/06/149f06037f450b664235b55c56c1b5a2.jpg',
        color: Colors.amberAccent);
  }
}
