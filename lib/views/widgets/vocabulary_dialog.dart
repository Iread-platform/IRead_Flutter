import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iread_flutter/bloc/StoryScreenBloc/storyscreen_bloc.dart';
import 'package:iread_flutter/bloc/comment_bloc/comment_bloc.dart';
import 'package:iread_flutter/bloc/text_selection_provider.dart';
import 'package:iread_flutter/services/auth_service.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:provider/provider.dart';

class VocabularyDialog {
  static String classOFWord = "";
  static TextEditingController def = TextEditingController();
  static TextEditingController example = TextEditingController();
  static Future vocDialog({@required context}) async {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            title: Row(
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
            ),
            content: SingleChildScrollView(
              child: Container(
                height: h * 0.4,
                width: w * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Container(
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Sections of speech"),
                                  margin: EdgeInsets.only(bottom: 5)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customBtn(text: "NOUN", setState: setState),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  customBtn(text: "VERB", setState: setState),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  customBtn(
                                      text: "ADJECTIVE", setState: setState),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
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
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Icon(
                              IReadIcons.list,
                              size: 30,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Container(
                            width: w * 0.3,
                            height: 30,
                            child: ElevatedButton(
                                onPressed: () {
                                  print(classOFWord);
                                  print(def.text);
                                  print(example.text);
                                  BlocProvider.of<CommentBloc>(context,
                                          listen: false)
                                      .addCommentWord({
                                    "interaction": {
                                      "storyId": 23,
                                      "studentId":
                                          AuthService().cU.id.toString(),
                                      "pageId": BlocProvider.of<
                                                  StoryscreenBloc>(context,
                                              listen: false)
                                          .storyPageData
                                          .data
                                          .pages[
                                              BlocProvider.of<StoryscreenBloc>(
                                                      context,
                                                      listen: false)
                                                  .pageController
                                                  .page
                                                  .toInt()]
                                          .pageId
                                    },
                                    "word": Provider.of<TextSelectionProvider>(
                                            context,
                                            listen: false)
                                        .wordSelection,
                                    "classOFWord": classOFWord,
                                    "definitionOfWord": def.text,
                                    "exampleOfWord": example.text
                                  });
                                },
                                child: Text("Save")),
                          ),
                          InkWell(
                            child: Icon(
                              IReadIcons.delete,
                              size: 30,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget customBtn({String text, setState}) {
    return Expanded(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: classOFWord == text
                ? Border.all(color: Colors.red, width: 3)
                : Border.all(color: Colors.transparent, width: 3)),
        child: ElevatedButton(
          child: Text(text),
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
      ),
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
