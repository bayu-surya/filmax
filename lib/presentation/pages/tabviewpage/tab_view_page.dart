import 'package:filmax/core/common/styles.dart';
import 'package:filmax/presentation/pages/tabviewpage/view1_page.dart';
import 'package:filmax/presentation/pages/tabviewpage/view2_page.dart';
import 'package:filmax/presentation/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TabViewPage extends StatefulWidget {
  static const routeName = '/tab_view_page';

  const TabViewPage();

  @override
  _TabViewPageState createState() => _TabViewPageState();
}

class _TabViewPageState extends State<TabViewPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tab View Page',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: controller,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.movie_creation_outlined,
                color: Colors.white,
              ),
              text: "Movie",
            ),
            Tab(
              icon: Icon(
                Icons.live_tv,
                color: Colors.white,
              ),
              text: "Tv Show",
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
      body: WillPopScope(
          child: TabBarView(
            controller: controller,
            children: <Widget>[
              View1Page(),
              View2Page(),
            ],
          ),
          onWillPop: _onWillPopA),
    );
  }

  Future<bool> _onWillPopA() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Peringatan"),
            content: Text(
              "Apakah anda akan keluar aplikasi ?",
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Tidak"),
              ),
              FlatButton(
                onPressed: () {
                  SystemNavigator.pop();
                  // if (Platform.isAndroid) {
                  // SystemNavigator.pop();
                  // } else if (Platform.isIOS) {
                  //   exit(0);
                  // }
                },
                textColor: primaryColor,
                child: Text('Ok'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
