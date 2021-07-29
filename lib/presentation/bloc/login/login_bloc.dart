import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/domain/entities/login.dart';
import 'package:filmax/domain/entities/user.dart';
import 'package:filmax/domain/usecases/post_create_session_login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PostCreateSessionLogin getLogin;

  LoginBloc({
    required PostCreateSessionLogin login,
  })  : getLogin = login,
        super(Empty()) {
    initialState;
  }

  LoginState get initialState => Empty();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent data,
  ) async* {
    if (data is GetDataForLogin) {
      final input = data.login;
      yield Loading();
      final failureOrLoaded = await getLogin(Params(login: input));
      yield* _eitherLoadedOrErrorState(failureOrLoaded);
    }
  }

  Stream<LoginState> _eitherLoadedOrErrorState(
    Either<Failure, User> failureOrLoaded,
  ) async* {
    yield failureOrLoaded.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (trivia) => Loaded(data: trivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
