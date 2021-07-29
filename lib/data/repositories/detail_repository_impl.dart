import 'package:dartz/dartz.dart';
import 'package:filmax/core/error/exception.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/platform/network_info.dart';
import 'package:filmax/core/util/data_mapper.dart';
import 'package:filmax/data/datasources/detail_remote_data_source.dart';
import 'package:filmax/domain/entities/delete_rating.dart';
import 'package:filmax/domain/entities/detail_movie.dart';
import 'package:filmax/domain/entities/movie_video.dart';
import 'package:filmax/domain/entities/rate.dart';
import 'package:filmax/domain/entities/review.dart';
import 'package:filmax/domain/repositories/detail_repository.dart';

class DetailRepositoryImpl implements DetailRepository {
  final DetailRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DetailRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DetailMovie>> getDetailMovie(String idMovie) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSource.getDetailMovie(idMovie);
        return Right(DataMapper().mapDetailMovieRemoteToEntities(data));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieVideo>>> getListMovieVideo(
      String idMovie) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSource.getListMovieVideo(idMovie);
        return Right(DataMapper().mapMovieVideoRemoteToEntities(data));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getReview(String idMovie) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSource.getReview(idMovie);
        return Right(DataMapper().mapReviewRemoteToEntities(data));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, DeleteRating>> deleteRating(
      String idMovie, String guestId, String sessionId) async {
    if (await networkInfo.isConnected) {
      try {
        final data =
            await remoteDataSource.deleteRating(idMovie, guestId, sessionId);
        return Right(DataMapper().mapDeleteRatingResponseToEntities(data));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, Rate>> postRateMovie(
      String idMovie, String guestId, String sessionId) async {
    if (await networkInfo.isConnected) {
      try {
        final data =
            await remoteDataSource.postRateMovie(idMovie, guestId, sessionId);
        return Right(DataMapper().mapRateResponseToEntities(data));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
