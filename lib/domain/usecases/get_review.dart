import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/usecase/usecase.dart';
import 'package:filmax/domain/entities/review.dart';
import 'package:filmax/domain/repositories/detail_repository.dart';

class GetReview implements UseCase<List<Review>, Params> {
  final DetailRepository repository;

  GetReview(this.repository);

  @override
  Future<Either<Failure, List<Review>>> call(Params params) async {
    return await repository.getReview(params.id);
  }
}

class Params extends Equatable {
  final String id;

  Params({required this.id});

  @override
  List<Object> get props => [id];
}
