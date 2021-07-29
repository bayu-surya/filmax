import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:filmax/core/platform/network_info.dart';
import 'package:filmax/data/datasources/detail_remote_data_source.dart';
import 'package:filmax/data/datasources/home_remote_data_source.dart';
import 'package:filmax/data/datasources/login_remote_data_source.dart';
import 'package:filmax/data/repositories/detail_repository_impl.dart';
import 'package:filmax/data/repositories/home_repository_impl.dart';
import 'package:filmax/data/repositories/login_repository_impl.dart';
import 'package:filmax/domain/repositories/detail_repository.dart';
import 'package:filmax/domain/repositories/home_repository.dart';
import 'package:filmax/domain/repositories/login_repository.dart';
import 'package:filmax/domain/usecases/delete_rating_movie.dart';
import 'package:filmax/domain/usecases/get_detail_movie.dart';
import 'package:filmax/domain/usecases/get_list_movie_now.dart';
import 'package:filmax/domain/usecases/get_list_movie_popular.dart';
import 'package:filmax/domain/usecases/get_list_movie_top.dart';
import 'package:filmax/domain/usecases/get_list_movie_upcoming.dart';
import 'package:filmax/domain/usecases/get_list_movie_video.dart';
import 'package:filmax/domain/usecases/get_review.dart';
import 'package:filmax/domain/usecases/post_create_session_login.dart';
import 'package:filmax/domain/usecases/post_rate_movie.dart';
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
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/util/input_converter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => MoviePopularBloc(
      // concrete: sl(),
      // inputConverter: sl(),
      popular: sl(),
    ),
  );
  sl.registerFactory(
    () => MovieTopBloc(
      top: sl(),
    ),
  );
  sl.registerFactory(
    () => MovieNowBloc(
      now: sl(),
    ),
  );
  sl.registerFactory(
    () => MovieUpcomingBloc(
      upcoming: sl(),
    ),
  );
  sl.registerFactory(
    () => DetailmovieBloc(
      detail: sl(),
    ),
  );
  sl.registerFactory(
    () => MovievideoBloc(
      video: sl(),
    ),
  );
  sl.registerFactory(
    () => LoginBloc(
      login: sl(),
    ),
  );
  sl.registerFactory(
    () => ReviewBloc(
      usacase: sl(),
    ),
  );
  sl.registerFactory(
    () => DeleteRatingBloc(
      usecase: sl(),
    ),
  );
  sl.registerFactory(
    () => RateMovieBloc(
      usecase: sl(),
    ),
  );
  sl.registerFactory(() => UserBloc());

  // Use cases
  sl.registerLazySingleton(() => GetListMoviePopular(sl()));
  sl.registerLazySingleton(() => GetListMovieTop(sl()));
  sl.registerLazySingleton(() => GetListMovieNow(sl()));
  sl.registerLazySingleton(() => GetListMovieUpcoming(sl()));
  sl.registerLazySingleton(() => GetListMovieVideo(sl()));
  sl.registerLazySingleton(() => GetDetailMovie(sl()));
  sl.registerLazySingleton(() => PostCreateSessionLogin(sl()));
  sl.registerLazySingleton(() => GetReview(sl()));
  sl.registerLazySingleton(() => PostRateMovie(sl()));
  sl.registerLazySingleton(() => DeleteRatingMovie(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      // localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<DetailRepository>(
    () => DetailRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources remote
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<DetailRemoteDataSource>(
    () => DetailRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(client: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());

  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);

  // Data sources local
  // sl.registerLazySingleton<NumberTriviaLocalDataSource>(
  //   () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  // );
}
