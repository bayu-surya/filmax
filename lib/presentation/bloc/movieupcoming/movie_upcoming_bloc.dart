import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/usecase/usecase.dart';
import 'package:filmax/domain/entities/movie.dart';
import 'package:filmax/domain/usecases/get_list_movie_upcoming.dart';

part 'movie_upcoming_event.dart';
part 'movie_upcoming_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class MovieUpcomingBloc extends Bloc<MovieUpcomingEvent, MovieUpcomingState> {
  final GetListMovieUpcoming getUpcoming;

  MovieUpcomingBloc({
    required GetListMovieUpcoming upcoming,
  })  : getUpcoming = upcoming,
        super(Empty()) {
    initialState;
  }

  MovieUpcomingState get initialState => Empty();

  @override
  Stream<MovieUpcomingState> mapEventToState(
    MovieUpcomingEvent event,
  ) async* {
    if (event is GetDataForUpcoming) {
      yield Loading();
      final failureOrLoaded = await getUpcoming(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrLoaded);
    }
  }

  Stream<MovieUpcomingState> _eitherLoadedOrErrorState(
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
