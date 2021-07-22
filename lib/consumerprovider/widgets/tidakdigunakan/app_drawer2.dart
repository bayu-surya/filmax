import 'package:flutter/material.dart';

import '../../common/styles.dart';
import '../../ui/tidakdigunakan/login.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(icon: Icons.home, text: 'Home',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.contacts)),
          _createDrawerItem(icon: Icons.play_circle_outline, text: 'Now Playing',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.contacts)),
          _createDrawerItem(icon: Icons.show_chart, text: 'Top Rated',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.contacts)),
          _createDrawerItem(icon: Icons.queue_play_next, text: 'Upcoming',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.contacts)),
          Divider(
            thickness: 1.0,
          ),
          _createDrawerItem(icon: Icons.help_outline, text: 'About',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.contacts)),
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
            // image: DecorationImage(
            //     fit: BoxFit.fill,
            //     image:  AssetImage('images/logo_movieku.png'))
        ),
        child:
        Column(
            mainAxisAlignment : MainAxisAlignment.center,
            crossAxisAlignment : CrossAxisAlignment.center,
            children: <Widget>[
        // Stack(children: <Widget>[
          Image.asset('images/logo_movieku.png', width: 20, height: 20),
          SizedBox(height: 10.0),
          Text(
            "Angkringan",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
          // Positioned(
          //     bottom: 12.0,
          //     left: 16.0,
          //     child: Text("Flutter Step-by-Step",
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 20.0,
          //             fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _createDrawerItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text!),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

class Routes {
  static const String contacts = Login.routeName;
  static const String events = Login.routeName;
  static const String notes = Login.routeName;
}