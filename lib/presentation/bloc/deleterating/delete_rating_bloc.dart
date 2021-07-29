import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/domain/entities/delete_rating.dart';
import 'package:filmax/domain/usecases/delete_rating_movie.dart';

part 'delete_rating_event.dart';
part 'delete_rating_state.dart';

class DeleteRatingBloc extends Bloc<DeleteRatingEvent, DeleteRatingState> {
  final DeleteRatingMovie deleteRating;

  DeleteRatingBloc({
    required DeleteRatingMovie usecase,
  })  : deleteRating = usecase,
        super(Empty()) {
    initialState;
  }

  DeleteRatingState get initialState => Empty();

  @override
  Stream<DeleteRatingState> mapEventToState(
    DeleteRatingEvent data,
  ) async* {
    if (data is GetDataForDelete) {
      final idMovie = data.idMovie;
      final guestId = data.guestId;
      final sessionId = data.sessionId;
      yield Loading();
      final failureOrLoaded = await deleteRating(Params(
        idMovie: idMovie,
        guestId: guestId,
        sessionId: sessionId,
      ));
      yield* _eitherLoadedOrErrorState(failureOrLoaded);
    } else if (data is GetDataForDeleteReset) {
      yield Empty();
    }
  }

  Stream<DeleteRatingState> _eitherLoadedOrErrorState(
    Either<Failure, DeleteRating> failureOrLoaded,
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
