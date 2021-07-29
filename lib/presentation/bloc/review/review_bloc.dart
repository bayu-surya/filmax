import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/domain/entities/review.dart';
import 'package:filmax/domain/usecases/get_review.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final GetReview getReview;

  ReviewBloc({
    required GetReview usacase,
  })  : getReview = usacase,
        super(Empty()) {
    initialState;
  }

  ReviewState get initialState => Empty();

  @override
  Stream<ReviewState> mapEventToState(
    ReviewEvent data,
  ) async* {
    if (data is GetDataForReview) {
      final input = data.id;
      yield Loading();
      final failureOrLoaded = await getReview(Params(id: input));
      yield* _eitherLoadedOrErrorState(failureOrLoaded);
    }
  }

  Stream<ReviewState> _eitherLoadedOrErrorState(
    Either<Failure, List<Review>> failureOrLoaded,
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
