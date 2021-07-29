import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/domain/entities/detail_movie.dart';
import 'package:filmax/domain/usecases/get_detail_movie.dart';

part 'detailmovie_event.dart';
part 'detailmovie_state.dart';

class DetailmovieBloc extends Bloc<DetailmovieEvent, DetailmovieState> {
  final GetDetailMovie getDetail;

  DetailmovieBloc({
    required GetDetailMovie detail,
  })  : getDetail = detail,
        super(Empty()) {
    initialState;
  }

  DetailmovieState get initialState => Empty();

  @override
  Stream<DetailmovieState> mapEventToState(
    DetailmovieEvent event,
  ) async* {
    if (event is GetDataForDetailmovie) {
      final input = event.id;
      yield Loading();
      final failureOrLoaded = await getDetail(Params(id: input));
      yield* _eitherLoadedOrErrorState(failureOrLoaded);
    }
  }

  Stream<DetailmovieState> _eitherLoadedOrErrorState(
    Either<Failure, DetailMovie> failureOrLoaded,
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
