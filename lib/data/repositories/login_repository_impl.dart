import 'package:dartz/dartz.dart';
import 'package:filmax/core/error/exception.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/platform/network_info.dart';
import 'package:filmax/data/datasources/login_remote_data_source.dart';
import 'package:filmax/data/models/create_session_remote.dart';
import 'package:filmax/data/models/guest_session_remote.dart';
import 'package:filmax/data/models/login_request.dart';
import 'package:filmax/domain/entities/login.dart';
import 'package:filmax/domain/entities/user.dart';
import 'package:filmax/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> createSessionLogin(Login login) async {
    if (await networkInfo.isConnected) {
      try {
        final dataGuest = await remoteDataSource.getGuestSession();
        try {
          final dataToken = await remoteDataSource.getRequestToken();
          try {
            LoginRequest loginRequest = LoginRequest(
                username: login.username,
                password: login.password,
                requestToken: dataToken.requestToken!);
            final dataLogin =
                await remoteDataSource.createSessionLogin(loginRequest);
            try {
              final dataSession =
                  await remoteDataSource.createSession(dataLogin.requestToken!);
              User user = User(
                sessionId: dataSession.sessionId,
                guestSessionId: dataGuest.guestSessionId,
                expiresAt: dataLogin.expiresAt,
                requestToken: dataLogin.requestToken,
              );
              return Right(user);
            } on ServerException {
              return Left(ServerFailure());
            }
          } on ServerException {
            return Left(ServerFailure());
          }
        } on ServerException {
          return Left(ServerFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  Future<Either<Failure, CreateSessionRemote>> createSession(
      String token) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSource.createSession(token);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  Future<Either<Failure, GuestSessionRemote>> getGuestSession() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSource.getGuestSession();
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
