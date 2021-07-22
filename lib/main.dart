import 'package:filmax/consumerprovider/data/api/api_service.dart';
import 'package:filmax/consumerprovider/provider/detailmovie_provider.dart';
import 'package:filmax/consumerprovider/provider/movievideo_provider.dart';
import 'package:filmax/consumerprovider/ui/movie_detail_page.dart';
import 'package:filmax/core/common/navigation.dart';
import 'package:filmax/core/common/styles.dart';
import 'package:filmax/injection_container.dart';
import 'package:filmax/presentation/bloc/movienow/movie_now_bloc.dart';
import 'package:filmax/presentation/bloc/moviepopular/movie_popular_bloc.dart';
import 'package:filmax/presentation/bloc/movietop/movie_top_bloc.dart';
import 'package:filmax/presentation/bloc/movieupcoming/movie_upcoming_bloc.dart';
import 'package:filmax/presentation/pages/home_page.dart';
import 'package:filmax/presentation/pages/splashscreen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DetailMovieProvider>(
          create: (_) => DetailMovieProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<MovieVideoProvider>(
          create: (_) => MovieVideoProvider(apiService: ApiService()),
        ),
      ],
      child: MultiBlocProvider(
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
            MovieDetailPage.routeName: (context) => MovieDetailPage(
                  id: ModalRoute.of(context)!.settings.arguments.toString(),
                ),
          },
        ),
      ),
    );
  }
}
