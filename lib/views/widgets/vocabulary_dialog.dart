import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'package:iread_flutter/bloc/comment_bloc/comment_bloc.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:iread_flutter/services/auth_service.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:provider/provider.dart';
import 'package:iread_flutter/models/story_model.dart';

class VocabularyDialog {
  static String classOFWord = "";
  static TextEditingController def = TextEditingController();
  static TextEditingController example = TextEditingController();
  static Future vocDialog({@required context}) async {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    classOFWord = "";
    example.text = "";
    def.text = "";
    // =========================== dialog =================================
    return showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            title: title(context),
            content: SingleChildScrollView(
              child: Container(
                height: h * 0.4,
                width: w * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    wordClass(),
                    Container(
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Definition of")),
                          customTextField("def"),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Useful phrase"),
                          ),
                          customTextField("example"),
                        ],
                      ),
                    ),
                    saveBtn(context)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future vocabularyList({@required context}) async {
    var comments = BlocProvider.of<StoryscreenBloc>(context)
        .storyPageData
        .data
        .pages[BlocProvider.of<StoryscreenBloc>(context)
            .pageController
            .page
            .toInt()]
        .comments;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Vocabulary",
                style: Theme.of(context).textTheme.headline3,
              ),
              InkWell(
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.9,
            child: StatefulBuilder(
              builder: (context, setStateList) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      child: Card(
                        child: Container(
                          height: 140,
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comments[index].word,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    Text("Word Class",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    Text(
                                      "        " + comments[index].classOFWord,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    Text(
                                      "Example",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      "        " +
                                          comments[index].exampleOfWord,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    Text(
                                      "Definition",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      "        " +
                                          comments[index].definitionOfWord,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                child: Icon(
                                  IReadIcons.delete,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onTap: () {
                                  var page = BlocProvider.of<StoryscreenBloc>(
                                          context,
                                          listen: false)
                                      .storyPageData
                                      .data
                                      .pages[BlocProvider.of<StoryscreenBloc>(
                                          context,
                                          listen: false)
                                      .pageController
                                      .page
                                      .toInt()];
                                  setStateList(() {
                                    BlocProvider.of<CommentBloc>(context)
                                        .removeCommentWord(
                                            comments[index].commentId);
                                    for (Word word in page.words) {
                                      if (word.content ==
                                          comments[index].word) {
                                        word.isComment = false;
                                      }
                                    }
                                    comments.removeAt(index);
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

// ================================== Widget ====================================
  static Widget saveBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 30,
      child: ElevatedButton(
          onPressed: () async {
            print(classOFWord);
            print(def.text);
            print(example.text);

            var page = BlocProvider.of<StoryscreenBloc>(context, listen: false)
                    .storyPageData
                    .data
                    .pages[
                BlocProvider.of<StoryscreenBloc>(context, listen: false)
                    .pageController
                    .page
                    .toInt()];
            Map<String, dynamic> newVoc = {
              "interaction": {
                "storyId": 23,
                "studentId": AuthService().cU.id.toString(),
                "pageId": page.pageId
              },
              "word": Provider.of<TextSelectionProvider>(context, listen: false)
                  .wordSelection,
              "classOFWord": classOFWord,
              "definitionOfWord": def.text,
              "exampleOfWord": example.text
            };
            //add interaction to server
            var json = await BlocProvider.of<CommentBloc>(context)
                .addCommentWord(newVoc);
            // add interaction to local page vocabulary
            page.comments.add(
              Comment.fromJson(json),
            );
            // MAKE WORD IS_VOCABULARY = TURE
            for (Word word in page.words) {
              if (word.content ==
                  Provider.of<TextSelectionProvider>(context, listen: false)
                      .wordSelection) {
                word.isComment = true;
              }
            }

            Navigator.pop(context);
          },
          child: Text("Save")),
    );
  }

  static Widget customBtn({String text, setState}) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: classOFWord == text
              ? Border.all(color: Colors.red, width: 3)
              : Border.all(color: Colors.transparent, width: 3)),
      child: ElevatedButton(
        child: FittedBox(
          child: Text(
            text,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
        onPressed: () {
          setState(() {
            classOFWord = text;
          });
        },
      ),
    );
  }

  static Widget title(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          Provider.of<TextSelectionProvider>(context).wordSelection,
          style: Theme.of(context).textTheme.headline3,
        ),
        InkWell(
          child: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.primary,
            size: 30,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  static Widget wordClass() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Sections of speech"),
                  margin: EdgeInsets.only(bottom: 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customBtn(text: "NOUN", setState: setState),
                  SizedBox(
                    width: 5,
                  ),
                  customBtn(text: "VERB", setState: setState),
                  SizedBox(
                    width: 5,
                  ),
                  customBtn(text: "ADJECTIVE", setState: setState),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  static Widget customTextField(String type) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 5),
      child: TextField(
        controller: type == "def" ? def : example,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          hintText: "write here",
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
