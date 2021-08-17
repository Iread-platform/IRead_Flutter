import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';
import 'package:iread_flutter/views/widgets/story/story_image.dart';
import 'package:iread_flutter/views/widgets/user/ranking.dart';

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class MyItem {
  MyItem({this.isExpanded: false, this.header, this.body});

  bool isExpanded;
  final String header;
  final String body;
}

class _StudentScreenState extends State<StudentScreen> {
  List<MyItem> _items = <MyItem>[
    new MyItem(header: 'Age', body: 'body'),
    new MyItem(header: 'PYP', body: 'body'),
    new MyItem(header: 'Script Form', body: 'body'),
    new MyItem(header: 'Subjects', body: 'body'),
  ];

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: h * 0.25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: w * 0.2,
                height: h * 0.3 * 0.8,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Icon(
                  IReadIcons.list,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
              ),
              Container(
                height: h * 0.25,
                width: w * 0.8,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Transform.translate(
                      offset: Offset(w * 0.1, -h * 0.05),
                      child: Transform.scale(
                        scale: 1.25,
                        child: SvgPicture.asset(
                          "assets/images/shared/curve_top_right.svg",
                          color: Colors.orangeAccent,
                          alignment: Alignment.topRight,
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        alignment: Alignment.center,
                        child: Ranking(
                          name: "Mohamad",
                          progress: 5.0,
                          rank: 16,
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: Text("Level 5", style: Theme.of(context).textTheme.headline3),
        ),
        for (int i = 0; i < _items.length; i++)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20)),
            child: ExpansionTile(
              title: Text(
                _items[i].header,
                style: Theme.of(context).textTheme.headline6,
              ),
              children: [
                Text(
                  _items[i].body,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
          ),
        Container(
          // height: 500,
          margin: EdgeInsets.all(10),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(5),
                child: StoryImage(
                  color: Colors.green,
                  imageUrl:
                      "https://cdn.shopify.com/s/files/1/2081/8163/files/022-I-FOUND-A-FROG-th.jpg?v=1589890624",
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
