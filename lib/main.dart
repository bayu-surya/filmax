import 'package:filmax/core/util/notification_helper.dart';
import 'package:filmax/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'injection_container.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //fcm
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  //injection
  await di.init();
  //notif
  final NotificationHelper _notificationHelper = NotificationHelper();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  // Constants.setEnvironment(Environment.DEV);
  runApp(MyApp());
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('atmoko background message ${message.notification!.body}');
}
