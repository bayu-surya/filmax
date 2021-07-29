import 'package:dartz/dartz.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/domain/entities/delete_rating.dart';
import 'package:filmax/domain/entities/detail_movie.dart';
import 'package:filmax/domain/entities/movie_video.dart';
import 'package:filmax/domain/entities/rate.dart';
import 'package:filmax/domain/entities/review.dart';

abstract class DetailRepository {
  Future<Either<Failure, List<MovieVideo>>> getListMovieVideo(String idMovie);
  Future<Either<Failure, DetailMovie>> getDetailMovie(String idMovie);
  Future<Either<Failure, List<Review>>> getReview(String idMovie);
  Future<Either<Failure, Rate>> postRateMovie(
      String idMovie, String guestId, String sessionId);
  Future<Either<Failure, DeleteRating>> deleteRating(
      String idMovie, String guestId, String sessionId);
}
