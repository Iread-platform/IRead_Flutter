import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iread_flutter/bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/Widgets/highlight_text.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class StoryScreen extends StatefulWidget {
  String strStory =
      '''Once upon a time there was an old mother pig who had three little pigs and not enough food to feed them. So when they were old enough, she sent them out into the world to seek their fortunes.

The first little pig was very lazy. He didn't want to work at all and he built his house out of straw. The second little pig worked a little bit harder but he was somewhat lazy too and he built his house out of sticks. Then, they sang and danced and played together the rest of the day.

The third little pig worked hard all day and built his house with bricks. It was a sturdy house complete with a fine fireplace and chimney. It looked like it could withstand the strongest winds.


 
The next day, a wolf happened to pass by the lane where the three little pigs lived; and he saw the straw house, and he smelled the pig inside. He thought the pig would make a mighty fine meal and his mouth began to water ''';

  StoryScreen({this.strStory});

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  bool play = true;
  var w;
  var h;
  var bloc;
  int i = 0;

  @override
  void initState() {
    super.initState();
    print("init");
    BlocProvider.of<StoryscreenBloc>(context).add(GetAudioEvent());
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    bloc = BlocProvider.of<StoryscreenBloc>(context);
    return Column(
      children: [
        header(), // HomeButton - backArrow - ImageStory
        textStory(), // Selectable text Story
        player(), // progress - playPauseButton
      ],
    );
  }

  Widget header() {
    return Container(
      height: h * 0.45,
      child: Stack(
        children: [
          Container(
            height: h * 0.45,
            child: Image.network(
              "https://www.jotform.com/blog/wp-content/uploads/2018/07/photos-with-story-featured-15.jpg",
              alignment: Alignment.bottomCenter,
            ),
          ),
          Transform.translate(
            offset: Offset(200, -140),
            child: Container(
              child: Container(
                child: Transform.scale(
                  scale: 1.2,
                  child: SvgPicture.asset(
                    "assets/images/shared/curve_top_right.svg",
                    color: Colors.orange[200],
                    alignment: Alignment.topLeft,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: h * 0.45,
            margin: EdgeInsets.all(40),
            alignment: Alignment.topRight,
            child: Icon(
              IReadIcons.arrow,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Container(
            height: 120,
            width: 120,
            alignment: Alignment.center,
            child: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            ),
          )
        ],
      ),
    );
  }

  Widget textStory() {
    return Container(
      height: h * 0.30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(
                IReadIcons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
                size: 40,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: HighlighText(
                  storyString: widget.strStory,
                  marginX: w * 0.15,
                  marginY: h * 0.45 - 10),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(
                IReadIcons.arrow,
                color: Theme.of(context).colorScheme.primary,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget player() {
    return Container(
        height: h * 0.25,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: Offset(-w * 0.5, h * 0.1),
              child: Transform.scale(
                scale: 1.6,
                child: SvgPicture.asset(
                  "assets/images/shared/curve_bottom_left.svg",
                  color: Colors.pink[200],
                  alignment: Alignment.topRight,
                ),
              ),
            ),
            BlocBuilder<StoryscreenBloc, StoryscreenState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return CircularProgressIndicator();
                } else {
                  BlocProvider.of<StoryscreenBloc>(context)
                      .add(HighlightWordEvent(index: Random().nextInt(10)));

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: w * 0.8,
                        alignment: Alignment.center,
                        child: progress(),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          child: Builder(builder: (context) {
                            if (bloc.audioPlayerState !=
                                AudioPlayerState.PLAYING) {
                              return Icon(
                                Icons.play_arrow,
                                color: Theme.of(context).colorScheme.primary,
                                size: 70,
                              );
                            } else {
                              return Icon(
                                Icons.pause,
                                color: Theme.of(context).colorScheme.primary,
                                size: 70,
                              );
                            }
                          }),
                          onTap: () {
                            if (!(bloc.audioPlayerState ==
                                AudioPlayerState.PLAYING)) {
                              bloc.add(ResumeEvent());
                            } else {
                              bloc.add(PauseEvent());
                            }
                          },
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ));
  }

  Widget progress() {
    return ProgressBar(
      progress: bloc.progress ?? Duration(seconds: 0),
      total: bloc.duration ?? Duration(seconds: 0),
      buffered: Duration(seconds: 15),
      progressBarColor: Theme.of(context).colorScheme.primary,
      bufferedBarColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      baseBarColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
      thumbColor: Theme.of(context).colorScheme.primary,
      barHeight: 20,
      onSeek: (duration) {
        print(duration);
        bloc.add(
          SeekEvent(
            duration,
          ),
        );
      },
    );
  }
}
