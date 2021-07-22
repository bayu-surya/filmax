import 'dart:io';

import 'package:filmax/consumerprovider/common/styles.dart';
import 'package:filmax/consumerprovider/provider/tidakdigunakan/login_provider.dart';
import 'package:filmax/consumerprovider/provider/tidakdigunakan/preferences_provider.dart';
import 'package:filmax/consumerprovider/provider/tidakdigunakan/scheduling_provider.dart';
import 'package:filmax/consumerprovider/widgets/tidakdigunakan/custom_dialog.dart';
import 'package:filmax/consumerprovider/widgets/tidakdigunakan/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/setting';

  const SettingsPage( );

  static const String settingsTitle = 'Settings';

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(settingsTitle,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return
          Column(
            children: <Widget>[
              SizedBox(height: 25.0),
              Row(
                children: <Widget>[
                  SizedBox( width : 25.0),
                  Expanded(
                    child:
                    Consumer<LoginProvider>(
                      builder: (context, login, _) {
                        return Text(
                          'Email : '+login.email,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: secondaryColor,
                      size: 26.0,
                    ),
                    onPressed: () {
                    },
                  ),
                  SizedBox( width : 10.0),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox( width : 25.0),
                  Expanded(
                    child:
                    Consumer<LoginProvider>(
                      builder: (context, login, _) {
                        return Text(
                          'Password : '+login.password,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: secondaryColor,
                      size: 26.0,
                    ),
                    onPressed: () {
                    },
                  ),
                  SizedBox( width : 10.0),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox( width : 25.0),
                  Expanded(
                    child: Text(
                      'Daily Reminder Notification',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Center(
                        child:
                        Switch.adaptive(
                          value: provider.isNotification,
                          onChanged: (value) async {
                            if (Platform.isIOS) {
                              customDialog(context);
                            } else {
                              scheduled.scheduledNews(value);
                              provider.enableNotification(value);
                            }
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox( width : 10.0),
                ],
              ),
            ],
          );
      },
    );
  }
}