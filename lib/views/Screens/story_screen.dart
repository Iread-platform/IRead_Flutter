import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
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
  GlobalKey stoyryKey = GlobalKey();
  //============== Fetch Story Data =========================
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StoryscreenBloc>(context).add(FetchStoryPage(stotyID: 0));
  }

  //=============== Build screen (Header - textStory - player) ===================
  @override
  Widget build(BuildContext context) {
    print("re build");
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    print(w);
    print(h);
    bloc = BlocProvider.of<StoryscreenBloc>(context, listen: false);
    return Column(
      children: [
        header(), // HomeButton - backArrow - ImageStory
        textStory(), // Selectable text Story
        player(), // progress - playPauseButton
      ],
    );
  }

  //============ header =============
  Widget header() {
    return Container(
      height: h * 0.45,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // ========= Story Image ==============
          Container(
            alignment: Alignment.bottomCenter,
            height: (h * 0.45),
            child: Image.network(
              "https://www.jotform.com/blog/wp-content/uploads/2018/07/photos-with-story-featured-15.jpg",
              alignment: Alignment.topLeft,
            ),
          ),
          // ========== curve_top_right ==============
          Transform.translate(
            offset: Offset(w * 0.3, -h * 0.2),
            child: Container(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                "assets/images/shared/curve_top_right.svg",
                color: Colors.orange[200],
                alignment: Alignment.topLeft,
              ),
            ),
          ),
          // ========== arrow Icon ==============
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
          // ========== home Icon ==============
          Container(
            height: h * 0.45,
            margin: EdgeInsets.all(40),
            alignment: Alignment.topLeft,
            child: Icon(
              Icons.home,
              color: Colors.purple,
              size: 60,
            ),
          )
        ],
      ),
    );
  }

  // ===================== Text Story ===============
  Widget textStory() {
    return Container(
      height: h * 0.30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ========= arrow Icon to go previous page =============
          Container(
            width: w * 0.15,
            child: InkWell(
              child: Icon(
                IReadIcons.arrow_back,
                color: Colors.purple,
                size: 40,
              ),
              onTap: () {
                bloc.pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
            ),
          ),
          // =========== Bloc builder Story Text Data ===============
          Container(
            width: w * 0.7,
            child: BlocBuilder<StoryscreenBloc, BlocState>(
              builder: (context, state) {
                scroll();
                return requsetHandlerStory();
              },
            ),
          ),
          // ========= arrow Icon to go next page =============
          Container(
            width: w * 0.15,
            child: InkWell(
              child: Icon(
                IReadIcons.arrow,
                color: Colors.purple,
                size: 40,
              ),
              onTap: () {
                bloc.pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============== player ( Progress - play Pause Icon ) ===============
  Widget player() {
    return Container(
        height: h * 0.25,
        child: Stack(
          children: [
            //================= Curve Bottom Left ===============
            Transform.translate(
              offset: Offset(-w * 0.2, h * 0.2),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Transform.scale(
                  scale: 1.6,
                  child: SvgPicture.asset(
                    "assets/images/shared/curve_bottom_left.svg",
                    color: Colors.pink[200],
                  ),
                ),
              ),
            ),
            //================= Player ===============
            BlocBuilder<StoryscreenBloc, BlocState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return Container();
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ========= progress =============
                      Container(
                        width: w * 0.8,
                        alignment: Alignment.center,
                        child: progress(),
                      ),
                      // ========= Play Pause Icon =============
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          child: Builder(builder: (context) {
                            if (bloc.audioPlayerState !=
                                AudioPlayerState.PLAYING) {
                              return Icon(
                                IReadIcons.play,
                                color: Colors.purple,
                                size: 40,
                              );
                            } else {
                              return Icon(
                                Icons.pause,
                                color: Colors.purple,
                                size: 40,
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
        print(bloc.storyPageData.data.words[int.parse(bloc.highLightIndex)]
            .scrollHight);
        Provider.of<TextSelectionProvider>(context, listen: false)
            .scrollController
            .animateTo(
                bloc.storyPageData.data.words[int.parse(bloc.highLightIndex)]
                    .scrollHight,
                duration: Duration(milliseconds: 500),
                curve: Curves.linear);
      },
    );
  }

  // this funcation call every 200 millisecound if word is hideen => scroll
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

  Widget requsetHandlerStory() {
    return RequestHandler<SuccessState, StoryscreenBloc>(
        main: Container(),
        onSuccess: (context, data) {
          return bloc.storyPageData != null ? stoyryPages() : Container();
        },
        other: bloc.storyPageData != null ? stoyryPages() : Container(),
        bloc: bloc);
  }

  Widget stoyryPages() {
    return Container(
      alignment: Alignment.topLeft,
      child: PageView(
        controller: bloc.pageController,
        children: [
          HighlighText(
              storyString: bloc.storyPageData.data.story ?? "",
              words: bloc.storyPageData.data.words ?? [],
              marginX: w * 0.15,
              marginY: h * 0.44),
          HighlighText(
              storyString: bloc.storyPageData.data.story ?? "",
              words: bloc.storyPageData.data.words ?? [],
              marginX: w * 0.15,
              marginY: h * 0.44),
          HighlighText(
              storyString: bloc.storyPageData.data.story ?? "",
              words: bloc.storyPageData.data.words ?? [],
              marginX: w * 0.15,
              marginY: h * 0.44),
        ],
      ),
    );
  }
}
