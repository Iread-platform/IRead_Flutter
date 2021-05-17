import 'package:flutter/material.dart';

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
            height: h * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.clear_rounded, size: 40, color: Colors.purple),
                iconWithText(title: " Home", icon: Icons.home, on_Tap: () {}),
                iconWithText(
                  title: " Open Library",
                  icon: Icons.menu_book_sharp,
                  on_Tap: () {},
                ),
                iconWithText(
                  title: " Assignment",
                  icon: Icons.assignment,
                  on_Tap: () {},
                ),
                iconWithText(
                  title: " Profile",
                  icon: Icons.person,
                  on_Tap: () {},
                ),
                iconWithText(
                  title: " Subtitles",
                  icon: Icons.subtitles,
                  on_Tap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget iconWithText({String title, IconData icon, Function on_Tap}) {
    return InkWell(
      splashColor: Colors.black.withOpacity(0.5),
      borderRadius: BorderRadius.circular(100),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(icon, size: 40, color: Colors.purple),
            Text(
              title,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
          ],
        ),
      ),
      onTap: on_Tap,
    );
  }
}
