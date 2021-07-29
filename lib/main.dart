import 'package:filmax/core/common/navigation.dart';
import 'package:filmax/core/common/styles.dart';
import 'package:filmax/injection_container.dart';
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
import 'package:filmax/presentation/pages/login_page.dart';
import 'package:filmax/presentation/pages/map_page.dart';
import 'package:filmax/presentation/pages/map_page_2.dart';
import 'package:filmax/presentation/pages/map_page_3.dart';
import 'package:filmax/presentation/pages/movie_detail/movie_detail_page.dart';
import 'package:filmax/presentation/pages/splashscreen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'injection_container.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          LoginPage.routeName: (context) => LoginPage(),
          MovieDetailPage.routeName: (context) => MovieDetailPage(
                id: ModalRoute.of(context)!.settings.arguments.toString(),
              ),
        },
      ),
    );
  }
}
