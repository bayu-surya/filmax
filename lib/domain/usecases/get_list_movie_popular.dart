import 'package:dartz/dartz.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/usecase/usecase.dart';
import 'package:filmax/domain/entities/movie.dart';
import 'package:filmax/domain/repositories/home_repository.dart';

class GetListMoviePopular implements UseCase<List<Movie>, NoParams> {
  final HomeRepository repository;

  GetListMoviePopular(this.repository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) async {
    return await repository.getListMoviePopuler();
  }
}
