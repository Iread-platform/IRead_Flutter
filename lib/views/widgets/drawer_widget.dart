import 'package:flutter/material.dart';
import 'package:iread_flutter/utils/i_read_icons.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(100),
        bottomRight: Radius.circular(100),
      ),
      child: Drawer(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: h * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.clear_rounded,
                    size: 40, color: Theme.of(context).colorScheme.primary),
                SizedBox(
                  height: 30,
                ),
                iconWithText(
                  context,
                  title: "Home",
                  icon: IReadIcons.home,
                  onTap: () {},
                ),
                iconWithText(
                  context,
                  title: "Open Library",
                  icon: IReadIcons.book,
                  onTap: () {},
                ),
                iconWithText(
                  context,
                  title: "Assignment",
                  icon: IReadIcons.assignment,
                  onTap: () {},
                ),
                iconWithText(
                  context,
                  title: "Profile",
                  icon: IReadIcons.profile,
                  onTap: () {},
                ),
                iconWithText(
                  context,
                  title: "Subtitles",
                  icon: IReadIcons.subtitles,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget iconWithText(BuildContext context,
      {String title, IconData icon, Function onTap}) {
    return InkWell(
      splashColor: Colors.black.withOpacity(0.5),
      borderRadius: BorderRadius.circular(100),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                child: Icon(icon,
                    size: 35, color: Theme.of(context).colorScheme.primary)),
            SizedBox(
              width: 20,
            ),
            Text(title, style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
