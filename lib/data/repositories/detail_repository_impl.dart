import 'package:dartz/dartz.dart';
import 'package:filmax/core/error/exception.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/platform/network_info.dart';
import 'package:filmax/core/util/data_mapper.dart';
import 'package:filmax/data/datasources/detail_remote_data_source.dart';
import 'package:filmax/domain/entities/detail_movie.dart';
import 'package:filmax/domain/entities/movie_video.dart';
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
        final remoteTrivia = await remoteDataSource.getDetailMovie(idMovie);
        return Right(DataMapper().mapDetailMovieRemoteToEntities(remoteTrivia));
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
        final remoteTrivia = await remoteDataSource.getListMovieVideo(idMovie);
        return Right(DataMapper().mapMovieVideoRemoteToEntities(remoteTrivia));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
