import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/usecase/usecase.dart';
import 'package:filmax/domain/entities/login.dart';
import 'package:filmax/domain/entities/user.dart';
import 'package:filmax/domain/repositories/login_repository.dart';

class PostCreateSessionLogin implements UseCase<User, Params> {
  final LoginRepository repository;

  PostCreateSessionLogin(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.createSessionLogin(params.login);
  }
}

class Params extends Equatable {
  final Login login;

  Params({required this.login});

  @override
  List<Object> get props => [login];
}
