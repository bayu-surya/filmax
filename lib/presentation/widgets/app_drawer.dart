import 'package:filmax/presentation/pages/home_page.dart';
import 'package:filmax/presentation/pages/popuppage/popup_page.dart';
import 'package:filmax/presentation/pages/tabviewpage/tab_view_page.dart';
import 'package:filmax/presentation/pages/tabviewpage/view_main_page.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  HomePage.routeName, (Route<dynamic> route) => false)),
          // Navigator.pushReplacementNamed(context, HomePage.routeName)),
          _createDrawerItem(
              icon: Icons.play_circle_outline,
              text: 'Tab View Page',
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  TabViewPage.routeName, (Route<dynamic> route) => false)),
          _createDrawerItem(
              icon: Icons.show_chart,
              text: 'View Page',
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  ViewMainPage.routeName, (Route<dynamic> route) => false)),
          _createDrawerItem(
              icon: Icons.queue_play_next,
              text: 'Popup Dialog',
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  PopupPage.routeName, (Route<dynamic> route) => false)),
          Divider(
            thickness: 1.0,
          ),
          _createDrawerItem(
              icon: Icons.help_outline,
              text: 'About',
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  HomePage.routeName, (Route<dynamic> route) => false)),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
      ),
      child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'images/logo_movieku.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Movie Pro",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ])),
    );
  }

  Widget _createDrawerItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text ?? ""),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
