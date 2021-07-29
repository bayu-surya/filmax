import 'package:dartz/dartz.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/domain/entities/login.dart';
import 'package:filmax/domain/entities/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> createSessionLogin(Login login);
}
