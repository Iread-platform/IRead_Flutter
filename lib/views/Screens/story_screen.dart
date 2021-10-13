import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iread_flutter/bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'package:iread_flutter/bloc/base/base_bloc.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/highlight_text.dart';
import 'package:iread_flutter/views/widgets/shared/request_handler.dart';
import 'package:iread_flutter/views/widgets/vocabulary_dialog.dart';
import 'package:provider/provider.dart';

class StoryScreen extends StatefulWidget {
  int storyId;
  StoryScreen({this.storyId});
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

    BlocProvider.of<StoryscreenBloc>(context)
        .add(FetchStoryPage(stotyID: widget.storyId));
  }

  //=============== Build screen (Header - textStory - player) ===================
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    bloc = BlocProvider.of<StoryscreenBloc>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(), // HomeButton - backArrow - ImageStory
            textStory(), // Selectable text Story
            player(), // progress - playPauseButton
          ],
        ),
      ),
    );
  }

  //============ header =============
  Widget header() {
    var url = null;
    try {
      url = BlocProvider.of<StoryscreenBloc>(context, listen: true)
          .storyPageData
          .data
          .pages[BlocProvider.of<StoryscreenBloc>(context)
              .pageController
              .page
              .toInt()]
          .imageURL;
    } catch (e) {}
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          // ========= Story Image ==============

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

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ========== arrow Icon ==============
              Container(
                margin:
                    EdgeInsets.only(top: 60, bottom: 50, left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ========== home Icon ==============
                    Container(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.home,
                        color: Theme.of(context).colorScheme.primary,
                        size: 40,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Icon(
                        IReadIcons.arrow,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: w,
                height: 200,
                child: url != null
                    ? FadeInImage.assetNetwork(
                        placeholder: 'assets/placholder.png',
                        image: url,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/placholder.png',
                        fit: BoxFit.cover,
                      ),
              ),
            ],
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ========= arrow Icon to go previous page =============
          Container(
            width: w * 0.15,
            child: InkWell(
              child: Icon(
                IReadIcons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
                size: 40,
              ),
              onTap: () {
                bloc.pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear);
                if (bloc.pageController.page.toInt() - 2 <= 0) {
                  bloc.add(SeekEvent(Duration(milliseconds: 0)));
                } else {
                  bloc.add(SeekEvent(Duration(
                      milliseconds: bloc
                          .storyPageData
                          .data
                          .pages[bloc.pageController.page.toInt() - 2]
                          .endPageTime
                          .toInt())));
                }
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
                color: Theme.of(context).colorScheme.primary,
                size: 40,
              ),
              onTap: () {
                bloc.pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear);
                bloc.add(SeekEvent(Duration(
                    milliseconds: bloc.storyPageData.data
                        .pages[bloc.pageController.page.toInt()].endPageTime
                        .toInt())));
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                color: Theme.of(context).colorScheme.primary,
                                size: 40,
                              );
                            } else {
                              return Icon(
                                Icons.pause,
                                color: Theme.of(context).colorScheme.primary,
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Icon(Icons.list,
                                size: 30,
                                color: Theme.of(context).colorScheme.primary),
                            onTap: () async {
                              return VocabularyDialog.vocabularyList(
                                  context: context);
                            },
                          ),
                          Icon(Icons.mic,
                              size: 30,
                              color: Theme.of(context).colorScheme.primary),
                          Icon(Icons.comment,
                              size: 30,
                              color: Theme.of(context).colorScheme.primary),
                        ],
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
      bufferedBarColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
      baseBarColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      thumbColor: Theme.of(context).colorScheme.primary,
      barHeight: 20,
      onSeek: (duration) {
        bloc.add(
          SeekEvent(
            duration,
          ),
        );

        Provider.of<TextSelectionProvider>(context, listen: false)
            .scrollController
            .animateTo(
                bloc.storyPageData.data.pages[bloc.pageController.page.toInt()]
                    .words[int.parse(bloc.highLightIndex)].scrollHight,
                duration: Duration(milliseconds: 500),
                curve: Curves.linear);
      },
    );
  }

  // this funcation call every 200 millisecound if word is hideen => scroll
  void scroll() {
    try {
      if (bloc.storyPageData.data.pages[bloc.pageController.page.toInt()]
              .words[int.parse(bloc.highLightIndex)].newLine &&
          BlocProvider.of<StoryscreenBloc>(context).audioPlayer.state ==
              AudioPlayerState.PLAYING) {
        Provider.of<TextSelectionProvider>(context, listen: false)
            .scrollController
            .animateTo(
                bloc.storyPageData.data.pages[bloc.pageController.page.toInt()]
                    .words[int.parse(bloc.highLightIndex)].scrollHight,
                duration: Duration(milliseconds: 400),
                curve: Curves.linear);
      }
    } catch (e) {
      print("scroll to word EXCEPTION ");
    }
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
      child: PageView(
        controller: bloc.pageController,
        onPageChanged: (value) {
          bloc.pageController.animateToPage(value,
              duration: Duration(milliseconds: 1000), curve: Curves.linear);
          if (value == 0) {
            bloc.add(SeekEvent(Duration(milliseconds: 0)));
          } else {
            bloc.add(SeekEvent(Duration(
                milliseconds: bloc
                    .storyPageData.data.pages[value - 1].endPageTime
                    .toInt())));
          }
        },
        children: [
          for (var i = 0; i < bloc.storyPageData.data.pages.length; i++)
            HighlighText(
                storyString: bloc.storyPageData.data.pages[i].content ?? "",
                words: bloc.storyPageData.data.pages[i].words ?? [],
                marginX: w * 0.15,
                marginY: h * 0.44),
        ],
      ),
    );
  }
}
