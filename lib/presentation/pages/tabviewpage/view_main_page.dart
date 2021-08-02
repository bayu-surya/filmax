import 'package:filmax/core/common/styles.dart';
import 'package:filmax/presentation/pages/tabviewpage/view1_page.dart';
import 'package:filmax/presentation/pages/tabviewpage/view2_page.dart';
import 'package:filmax/presentation/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewMainPage extends StatefulWidget {
  static const routeName = '/view_main_page';

  const ViewMainPage();

  @override
  _ViewMainPageState createState() => _ViewMainPageState();
}

class _ViewMainPageState extends State<ViewMainPage> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Page',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: WillPopScope(
          child: PageView(
            controller: _controller,
            children: [
              View1Page(),
              View2Page(),
            ],
          ),
          onWillPop: _onWillPopA),
      // ),
    );
  }

  Future<bool> _onWillPopA() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Text("Peringatan"),
            content: Text(
              "Apakah anda akan keluar aplikasi ?",
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Tidak"),
              ),
              new FlatButton(
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
