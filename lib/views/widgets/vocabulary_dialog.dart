import 'package:flutter/material.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';

class VocabularyDialog {
  static Future VocDialog({@required context}) async {
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
                  "But",
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
                    Container(
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Sections of speech"),
                              margin: EdgeInsets.only(bottom: 5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customBtn(text: "Noun"),
                              SizedBox(
                                width: 5,
                              ),
                              customBtn(text: "Verb"),
                              SizedBox(
                                width: 5,
                              ),
                              customBtn(text: "Letter"),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Definition of")),
                          customTextField(),
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
                          customTextField(),
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
                                onPressed: () {}, child: Text("Save")),
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

  static Widget customBtn({String text}) {
    return Expanded(
      child: Container(
        height: 25,
        child: ElevatedButton(
          child: Text(text),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  static Widget customTextField() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 5),
      child: TextField(
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
