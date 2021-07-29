import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/domain/entities/rate.dart';
import 'package:filmax/domain/usecases/post_rate_movie.dart';

part 'rate_movie_event.dart';
part 'rate_movie_state.dart';

class RateMovieBloc extends Bloc<RateMovieEvent, RateMovieState> {
  final PostRateMovie postRate;

  RateMovieBloc({
    required PostRateMovie usecase,
  })  : postRate = usecase,
        super(Empty()) {
    initialState;
  }

  RateMovieState get initialState => Empty();

  @override
  Stream<RateMovieState> mapEventToState(
    RateMovieEvent data,
  ) async* {
    if (data is GetDataForRateMovie) {
      final idMovie = data.idMovie;
      final guestId = data.guestId;
      final sessionId = data.sessionId;
      yield Loading();
      final failureOrLoaded = await postRate(Params(
        idMovie: idMovie,
        guestId: guestId,
        sessionId: sessionId,
      ));
      yield* _eitherLoadedOrErrorState(failureOrLoaded);
    } else if (data is GetDataForRateMovieReset) {
      yield Empty();
    }
  }

  Stream<RateMovieState> _eitherLoadedOrErrorState(
    Either<Failure, Rate> failureOrLoaded,
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
