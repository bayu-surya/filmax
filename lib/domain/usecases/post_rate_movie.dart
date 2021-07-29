import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/usecase/usecase.dart';
import 'package:filmax/domain/entities/rate.dart';
import 'package:filmax/domain/repositories/detail_repository.dart';

class PostRateMovie implements UseCase<Rate, Params> {
  final DetailRepository repository;

  PostRateMovie(this.repository);

  @override
  Future<Either<Failure, Rate>> call(Params params) async {
    return await repository.postRateMovie(
        params.idMovie, params.guestId, params.sessionId);
  }
}

class Params extends Equatable {
  final String idMovie;
  final String guestId;
  final String sessionId;

  Params(
      {required this.idMovie, required this.guestId, required this.sessionId});

  @override
  List<Object> get props => [idMovie, guestId, sessionId];
}
