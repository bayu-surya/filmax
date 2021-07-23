import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/usecase/usecase.dart';
import 'package:filmax/domain/entities/detail_movie.dart';
import 'package:filmax/domain/repositories/detail_repository.dart';

class GetDetailMovie implements UseCase<DetailMovie, Params> {
  final DetailRepository repository;

  GetDetailMovie(this.repository);

  @override
  Future<Either<Failure, DetailMovie>> call(Params params) async {
    return await repository.getDetailMovie(params.id);
  }
}

class Params extends Equatable {
  final String id;

  Params({required this.id});

  @override
  List<Object> get props => [id];
}
