import 'package:dartz/dartz.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/domain/entities/movie.dart';

abstract class HomeRepository {
  // Future<Either<Failure, Movie>> getListMoviePopuler(int number);
  Future<Either<Failure, List<Movie>>> getListMoviePopuler();
  Future<Either<Failure, List<Movie>>> getListMovieTop();
  Future<Either<Failure, List<Movie>>> getListMovieUpcoming();
  Future<Either<Failure, List<Movie>>> getListMovieNow();
}
