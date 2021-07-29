import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/usecase/usecase.dart';
import 'package:filmax/domain/entities/movie.dart';
import 'package:filmax/domain/usecases/get_list_movie_now.dart';

part 'movie_now_event.dart';
part 'movie_now_state.dart';

class MovieNowBloc extends Bloc<MovieNowEvent, MovieNowState> {
  final GetListMovieNow getNow;

  MovieNowBloc({
    required GetListMovieNow now,
  })  : getNow = now,
        super(Empty()) {
    initialState;
  }

  MovieNowState get initialState => Empty();

  @override
  Stream<MovieNowState> mapEventToState(
    MovieNowEvent event,
  ) async* {
    if (event is GetDataForNow) {
      yield Loading();
      final failureOrLoaded = await getNow(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrLoaded);
    }
  }

  Stream<MovieNowState> _eitherLoadedOrErrorState(
    Either<Failure, List<Movie>> failureOrLoaded,
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
