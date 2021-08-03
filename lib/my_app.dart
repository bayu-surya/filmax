import 'package:filmax/core/common/navigation.dart';
import 'package:filmax/core/common/styles.dart';
import 'package:filmax/core/util/localizations_delegate.dart';
import 'package:filmax/core/util/notification_helper.dart';
import 'package:filmax/domain/entities/movie.dart';
import 'package:filmax/injection_container.dart';
import 'package:filmax/main.dart';
import 'package:filmax/presentation/bloc/deleterating/delete_rating_bloc.dart';
import 'package:filmax/presentation/bloc/detailmovie/detailmovie_bloc.dart';
import 'package:filmax/presentation/bloc/login/login_bloc.dart';
import 'package:filmax/presentation/bloc/movienow/movie_now_bloc.dart';
import 'package:filmax/presentation/bloc/moviepopular/movie_popular_bloc.dart';
import 'package:filmax/presentation/bloc/movietop/movie_top_bloc.dart';
import 'package:filmax/presentation/bloc/movieupcoming/movie_upcoming_bloc.dart';
import 'package:filmax/presentation/bloc/movievideo/movievideo_bloc.dart';
import 'package:filmax/presentation/bloc/ratemovie/rate_movie_bloc.dart';
import 'package:filmax/presentation/bloc/review/review_bloc.dart';
import 'package:filmax/presentation/bloc/user/user_bloc.dart';
import 'package:filmax/presentation/pages/home_page.dart';
import 'package:filmax/presentation/pages/home_page2.dart';
import 'package:filmax/presentation/pages/login_page.dart';
import 'package:filmax/presentation/pages/map/map_main_page.dart';
import 'package:filmax/presentation/pages/map/map_page.dart';
import 'package:filmax/presentation/pages/map/map_page_2.dart';
import 'package:filmax/presentation/pages/map/map_page_3.dart';
import 'package:filmax/presentation/pages/movie_detail/movie_detail_page.dart';
import 'package:filmax/presentation/pages/popuppage/popup_page.dart';
import 'package:filmax/presentation/pages/splashscreen_page.dart';
import 'package:filmax/presentation/pages/tabviewpage/tab_view_page.dart';
import 'package:filmax/presentation/pages/tabviewpage/view_main_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseMessaging messaging;

  @override
  void initState() {
    //fcm
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print("atmoko 1 token " + value!);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      final NotificationHelper _notificationHelper = NotificationHelper();
      // callback(_notificationHelper, event.notification!.body!);
      Movie data = Movie(
          adult: true,
          backdropPath: "null",
          genreIds: [0],
          id: 1,
          originalLanguage: "originalLanguage",
          originalTitle: "originalTitle",
          overview: "overview",
          popularity: 1,
          posterPath: "posterPath",
          releaseDate: DateTime.parse("2000-01-01"),
          title: "title",
          video: false,
          voteAverage: 1,
          voteCount: 1);
      showNotification(_notificationHelper, data);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('atmoko Message clicked!');
    });
    requestPermission(messaging);
    setForegroundNotificationPresentationOptions();
  }

  static Future<void> showNotification(
      NotificationHelper _notificationHelper, Movie _data) async {
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, _data);
  }

  // permission ios
  static Future<void> requestPermission(FirebaseMessaging _messaging) async {
    print('atmoko aaaaaaaaaaaaa');
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  static Future<void> setForegroundNotificationPresentationOptions() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null && initialMessage.data['type'] == 'chat') {
      // Navigator.pushNamed(context, '/chat',
      //     arguments: ChatArguments(initialMessage));
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['type'] == 'chat') {
        // Navigator.pushNamed(context, '/chat',
        //     arguments: ChatArguments(message));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<MovieTopBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<MovieNowBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<MovieUpcomingBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<MovievideoBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<DetailmovieBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<LoginBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<ReviewBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<RateMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<DeleteRatingBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<UserBloc>(),
        ),
        // BlocProvider<MoviePopularBloc>(
        // create: (BuildContext context) => MoviePopularBloc( popular: sl<MoviePopularBloc>()),
        // ),
      ],
      child: MaterialApp(
        title: 'Filmax',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: secondaryColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: myTextTheme,
          appBarTheme: AppBarTheme(
            textTheme: myTextTheme.apply(bodyColor: Colors.black),
            elevation: 0,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: primaryColor,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
        ),
        navigatorKey: navigatorKey,
        initialRoute: Splashscreen.routeName,
        routes: {
          Splashscreen.routeName: (context) => Splashscreen(),
          HomePage.routeName: (context) => HomePage(),
          MapPage.routeName: (context) => MapPage(),
          Map2Page.routeName: (context) => Map2Page(),
          Map3Page.routeName: (context) => Map3Page(),
          MapMainPage.routeName: (context) => MapMainPage(),
          TabViewPage.routeName: (context) => TabViewPage(),
          ViewMainPage.routeName: (context) => ViewMainPage(),
          PopupPage.routeName: (context) => PopupPage(),
          LoginPage.routeName: (context) => LoginPage(),
          HomePage2.routeName: (context) => HomePage2(),
          MovieDetailPage.routeName: (context) => MovieDetailPage(
                id: ModalRoute.of(context)!.settings.arguments.toString(),
              ),
        },
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('id', 'ID'),
        ],
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback:
            (Locale? locale, Iterable<Locale> supportedLocales) {
          for (Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode ||
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}
