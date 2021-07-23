import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/usecase/usecase.dart';
import 'package:filmax/domain/entities/movie_video.dart';
import 'package:filmax/domain/repositories/detail_repository.dart';

class GetListMovieVideo implements UseCase<List<MovieVideo>, Params> {
  final DetailRepository repository;

  GetListMovieVideo(this.repository);

  @override
  Future<Either<Failure, List<MovieVideo>>> call(Params params) async {
    return await repository.getListMovieVideo(params.id);
  }
}

class Params extends Equatable {
  final String id;

  Params({required this.id});

  @override
  List<Object> get props => [id];
}
