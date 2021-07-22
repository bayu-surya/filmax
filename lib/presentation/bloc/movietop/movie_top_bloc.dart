import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/usecase/usecase.dart';
import 'package:filmax/domain/entities/movie.dart';
import 'package:filmax/domain/usecases/get_list_movie_top.dart';
import 'package:meta/meta.dart';

part 'movie_top_event.dart';
part 'movie_top_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class MovieTopBloc extends Bloc<MovieTopEvent, MovieTopState> {
  final GetListMovieTop getTop;

  MovieTopBloc({
    required GetListMovieTop top,
  })  : getTop = top,
        super(Empty()) {
    initialState;
  }

  MovieTopState get initialState => Empty();

  @override
  Stream<MovieTopState> mapEventToState(
    MovieTopEvent event,
  ) async* {
    if (event is GetDataForTop) {
      yield Loading();
      final failureOrLoaded = await getTop(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrLoaded);
    }
  }

  Stream<MovieTopState> _eitherLoadedOrErrorState(
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
