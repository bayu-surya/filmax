import 'dart:async';

import 'package:filmax/core/common/styles.dart';
import 'package:filmax/presentation/pages/home_page.dart';
// import 'package:filmax/consumerprovider/ui/home_page.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  static const routeName = '/splashscreen';

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late Timer _timer;
  int _start = 5;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/logo_movieku.png', width: 200, height: 200),
            SizedBox(height: 10.0),
            Text(
              "movieku",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const _oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      _oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
