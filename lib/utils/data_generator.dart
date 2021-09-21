import 'package:flutter/material.dart';
import 'package:iread_flutter/models/story.dart';

class DataGenerator {
  /*static ProjectModel project() {
    ProjectModel project = new ProjectModel(
        name: "Paint my wall",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eu nisl quis tellus rutrum dignissim. Aenean at euismod nisi. Nulla mollis urna nec arcu mollis dignissim nec ut dolor. Suspendisse dignissim, tortor eget tempor finibus, purus nisi gravida erat, sit amet ultrices ex erat eu enim. Curabitur sit amet magna at orci luctus egestas. Cras dictum ornare vestibulum. Pellentesque euismod, nibh id maximus hendrerit, tellus nunc molestie est, et accumsan tellus risus a justo. Integer faucibus consectetur felis, ac blandit neque luctus quis. Donec in est ac arcu auctor pulvinar. Vestibulum turpis nisl, faucibus vitae suscipit ut, mattis eu tortor." +

            "Aliquam sed sollicitudin sapien. Nullam accumsan urna ultricies, posuere ipsum eu, tincidunt ex. Praesent accumsan dui eget risus euismod, vitae semper tortor feugiat. Quisque interdum placerat dui ut efficitur. Praesent dapibus ligula felis, a porta diam vestibulum tristique. Morbi lacus massa, tincidunt sed tempor sit amet, fermentum non risus. Ut vulputate odio eu tellus viverra, in accumsan enim placerat. Aliquam erat volutpat. Nam sit amet orci metus. Curabitur efficitur neque orci, sed tincidunt ligula feugiat eget. Vestibulum aliquet arcu placerat tellus auctor ornare. Quisque ut est sed nulla tristique ultricies ut vitae dolor. Nunc sit amet ligula blandit metus accumsan pharetra. Vivamus vel pharetra felis, ut maximus enim." +

            "In sit amet venenatis dolor. Donec porttitor massa rhoncus mi venenatis vestibulum non fermentum felis. Praesent viverra enim et nibh posuere, ac volutpat lorem lobortis. Donec feugiat nunc eu eros rutrum imperdiet vel vel ipsum. Donec maximus eros vel nisl commodo, a luctus nisl interdum. Vestibulum at neque nulla. Morbi sodales justo eget laoreet interdum. Sed magna est, volutpat in ipsum volutpat, finibus sagittis nisl. Etiam lobortis eros eu pretium faucibus. Donec sed quam id mauris lobortis lacinia. Ut et eros nec libero consequat luctus." +

            "Nunc consequat sagittis magna vitae vehicula. Morbi nibh ligula, blandit ac consectetur vitae, gravida euismod lorem. Curabitur cursus ornare velit et vehicula. Sed tristique orci non lectus finibus lobortis. Quisque lectus purus, ultrices non mauris eget, viverra dapibus lacus. Curabitur dictum libero vitae erat mollis sagittis id ac libero. Ut bibendum mollis quam, quis tempus nisl tristique non. Nam pulvinar sodales dui sit amet aliquam. Aliquam fermentum dui quam, a pharetra nisi pulvinar semper. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam in posuere sapien, a eleifend nisi. Mauris facilisis magna in consequat eleifend. Praesent a ante et tellus lobortis pharetra sit amet eget velit. Duis mollis sapien ligula, hendrerit laoreet ante lobortis in. Nulla pretium vestibulum libero.",
        ownerId: 1,
        expireDate: DateTime
            .now()
            .microsecondsSinceEpoch,
        startDate: DateTime
            .now()
            .microsecondsSinceEpoch + 2000 * 2000,
        active: true);

    return project;
  }*/

  static List<String> mediaList() {
    int count = 20;

    List<String> media = [];
    for (int i = 0; i < count; i++) {
      media.add(
          'data:image/jpeg;base64,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');
    }

    return media;
  }

  static Story story() {
    return Story(
        title: 'Wood, Wire, Wings',
        color: Colors.black38,
        imageUrl: 'https://picsum.photos/200/300',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sit amet lacus tincidunt, consequat lorem ac, consectetur ligula. Sed non nunc vehicula, pretium arcu a, faucibus eros. Cras lacinia magna sed enim malesuada finibus. Nulla et varius neque. Etiam dolor erat, dictum sodales facilisis ac, cursus vehicula lacus. Vestibulum et ante lorem. Pellentesque pretium arcu felis, nec efficitur lacus ultricies quis. Morbi eu tortor facilisis, porta elit quis, varius diam.',
        writer: 'Motasem Ghozlan',
        pages: 1300,
        progress: 0.45,
        flippedPages: 53,
        readingTime: 127.25);
  }

  static List<Story> storyList(int count) {
    List<Story> stories = [];

    for (int i = 0; i < count; i++) {
      stories.add(story());
    }

    return stories;
  }
}
