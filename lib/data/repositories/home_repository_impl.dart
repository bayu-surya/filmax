import 'package:dartz/dartz.dart';
import 'package:filmax/core/error/exception.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/platform/network_info.dart';
import 'package:filmax/core/util/data_mapper.dart';
import 'package:filmax/data/datasources/home_remote_data_source.dart';
import 'package:filmax/domain/entities/movie.dart';
import 'package:filmax/domain/repositories/home_repository.dart';

// typedef Future<NumberTrivia> _ConcreteOrRandomChooser();
// typedef Future<MoviePopular> _ConcreteOrRandomChooser();

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  // final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    // required this.localDataSource,
    required this.networkInfo,
  });

  // @override
  // Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
  //     int number,
  //     ) async {
  //   return await _getTrivia(() {
  //     return remoteDataSource.getConcreteNumberTrivia(number);
  //   });
  // }

  // @override
  // Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
  //   return await _getTrivia(() {
  //     return remoteDataSource.getRandomNumberTrivia();
  //   });
  // }
  //
  // Future<Either<Failure, NumberTrivia>> _getTrivia(
  //   _ConcreteOrRandomChooser getConcreteOrRandom,
  // ) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final remoteTrivia = await getConcreteOrRandom();
  //       localDataSource.cacheNumberTrivia(remoteTrivia);
  //       return Right(remoteTrivia);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     try {
  //       final localTrivia = await localDataSource.getLastNumberTrivia();
  //       return Right(localTrivia);
  //     } on CacheException {
  //       return Left(CacheFailure());
  //     }
  //   }
  // }

  @override
  Future<Either<Failure, List<Movie>>> getListMoviePopuler() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await remoteDataSource.getListMovePopular();
        // localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(
            DataMapper().mapMoviePopularRemoteToEntities(remoteTrivia.results));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      // try {
      //   // final localTrivia = await localDataSource.getLastNumberTrivia();
      //   return Right(localTrivia);
      // } on CacheException {
      return Left(NoInternetFailure());
      // }
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getListMovieTop() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await remoteDataSource.getListMoveTop();
        return Right(
            DataMapper().mapMovieTopRemoteToEntities(remoteTrivia.results));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getListMovieNow() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await remoteDataSource.getListMovieNow();
        return Right(
            DataMapper().mapMovieNowRemoteToEntities(remoteTrivia.results));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getListMovieUpcoming() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await remoteDataSource.getListMovieUpcoming();
        return Right(DataMapper()
            .mapMovieUpcomingRemoteToEntities(remoteTrivia.results));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
