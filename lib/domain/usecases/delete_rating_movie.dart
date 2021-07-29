import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/usecase/usecase.dart';
import 'package:filmax/domain/entities/delete_rating.dart';
import 'package:filmax/domain/repositories/detail_repository.dart';

class DeleteRatingMovie implements UseCase<DeleteRating, Params> {
  final DetailRepository repository;

  DeleteRatingMovie(this.repository);

  @override
  Future<Either<Failure, DeleteRating>> call(Params params) async {
    return await repository.deleteRating(
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
