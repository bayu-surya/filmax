import 'package:filmax/presentation/pages/popuppage/custom_dialog.dart';
import 'package:filmax/presentation/pages/popuppage/custom_dialog2.dart';
import 'package:filmax/presentation/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class PopupPage extends StatefulWidget {
  static const routeName = '/popup_page';

  @override
  _PopupPageState createState() => _PopupPageState();
}

class _PopupPageState extends State<PopupPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Popup Dialog',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: Container(
        child: Center(
            child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox(
                        title: "Custom Dialog Demo",
                        descriptions:
                            "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                        text: "Yes",
                      );
                    });
              },
              child: Text("Custom Dialog"),
            ),
            RaisedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox2();
                    });
              },
              child: Text("Custom Dialog 2"),
            ),
          ],
        )),
      ),
    );
  }
}
