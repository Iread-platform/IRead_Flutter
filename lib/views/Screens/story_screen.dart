import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iread_flutter/bloc/story_player_bloc.dart';
import 'package:iread_flutter/views/Widgets/highlight_text.dart';
import 'package:iread_flutter/views/Widgets/media/story_audio_player.dart';
import 'package:provider/provider.dart';
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
  var bloc;

  @override
  void initState() {
    bloc = Provider.of<StoryPlayerBloc>(context, listen: false);
    super.initState();
    bloc.play(
        "https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_5MG.mp3");
    // bloc.pause();
  }

  bool play = true;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
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
                  Icons.arrow_forward_ios_rounded,
                  size: 40,
                  color: Colors.purple,
                ),
              ),
              Container(
                height: 120,
                width: 120,
                alignment: Alignment.center,
                child: Icon(
                  Icons.menu,
                  color: Colors.purple,
                  size: 40,
                ),
              )
            ],
          ),
        ),
        Container(
          height: h * 0.30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.purple,
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
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.purple,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
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
              Container(
                width: w * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<StoryPlayerBloc>(
                      builder: (context, value, child) {
                        if (value.duration != null && value.progress != null) {
                          return Container(
                            margin: EdgeInsets.only(top: 50),
                            child: ProgressBar(
                              progress: value.progress,
                              thumbRadius: 0,
                              barHeight: 20,
                              progressBarColor: Colors.purple,
                              baseBarColor: Colors.purple.withOpacity(0.24),
                              bufferedBarColor: Colors.purple.withOpacity(0.3),
                              thumbColor: Colors.purple,
                              timeLabelTextStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  height: 2),
                              buffered: Duration(milliseconds: 90000),
                              total: value.duration,
                              onSeek: (duration) {
                                bloc.seek(duration);
                              },
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    Consumer<StoryPlayerBloc>(
                      builder: (context, value, child) {
                        if (value.duration != null && value.progress != null) {
                          return Container(
                            child: InkWell(
                              child: Icon(
                                value.audioPlayerState ==
                                        AudioPlayerState.PLAYING
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.purple,
                                size: 70,
                              ),
                              onTap: () {
                                if (!(value.audioPlayerState ==
                                    AudioPlayerState.PLAYING)) {
                                  bloc.resume();
                                } else {
                                  bloc.pause();
                                }
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
