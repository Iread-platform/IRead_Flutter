import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iread_flutter/bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/Widgets/highlight_text.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:iread_flutter/views/Widgets/shared/request_handler.dart';
import 'package:provider/provider.dart';

class StoryScreen extends StatefulWidget {
  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  bool play = true;
  var w;
  var h;
  var bloc;
  var blocListener;
  GlobalKey stoyryKey = GlobalKey();
  double x = 10;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StoryscreenBloc>(context).add(FetchStoryPage());
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    bloc = BlocProvider.of<StoryscreenBloc>(context);
    blocListener = BlocProvider.of<StoryscreenBloc>(context, listen: true);
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
              color: Colors.purple,
            ),
          ),
          Container(
            height: 120,
            width: 120,
            alignment: Alignment.center,
            child: Icon(
              IReadIcons.home,
              color: Colors.purple,
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
          Container(
            width: w * 0.15,
            child: Icon(
              IReadIcons.arrow_back,
              color: Colors.purple,
              size: 40,
            ),
          ),
          Container(
            width: w * 0.7,
            child: BlocBuilder<StoryscreenBloc, BlocState>(
              builder: (context, state) {
                scroll();
                return requsetHandlerStory();
              },
            ),
          ),
          Container(
            width: w * 0.15,
            child: Icon(
              IReadIcons.arrow,
              color: Colors.purple,
              size: 40,
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
            BlocBuilder<StoryscreenBloc, BlocState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return Container();
                } else {
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
                                IReadIcons.play,
                                color: Colors.purple,
                                size: 70,
                              );
                            } else {
                              return Icon(
                                Icons.pause,
                                color: Colors.purple,
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
      progressBarColor: Colors.purple,
      bufferedBarColor: Colors.purple.withOpacity(0.3),
      baseBarColor: Colors.purple.withOpacity(0.2),
      thumbColor: Colors.purple,
      barHeight: 20,
      onSeek: (duration) {
        bloc.add(
          SeekEvent(
            duration,
          ),
        );
      },
    );
  }

  void scroll() {
    try {
      if (bloc
          .storyPageData.data.words[int.parse(bloc.highLightIndex)].newLine) {
        Provider.of<TextSelectionProvider>(context, listen: false)
            .scrollController
            .animateTo(
                bloc.storyPageData.data.words[int.parse(bloc.highLightIndex)]
                    .scrollHight,
                duration: Duration(milliseconds: 500),
                curve: Curves.linear);
      }
    } catch (e) {}
  }
  Widget requsetHandlerStory(){
    return RequestHandler<SuccessState, StoryscreenBloc>(
                    main: Container(),
                    other: blocListener.storyPageData != null
                        ? Container(
                            alignment: Alignment.topLeft,
                            child: HighlighText(
                                storyString:
                                    blocListener.storyPageData.data.story ?? "",
                                words:
                                    blocListener.storyPageData.data.words ?? [],
                                marginX: w * 0.15,
                                marginY: h * 0.44),
                          )
                        : Container(),
                    bloc: bloc);
  }
}
