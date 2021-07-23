import 'package:dartz/dartz.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/domain/entities/detail_movie.dart';
import 'package:filmax/domain/entities/movie_video.dart';

abstract class DetailRepository {
  Future<Either<Failure, List<MovieVideo>>> getListMovieVideo(String idMovie);
  Future<Either<Failure, DetailMovie>> getDetailMovie(String idMovie);
}
