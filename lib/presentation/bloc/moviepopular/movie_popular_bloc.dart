import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/core/usecase/usecase.dart';
import 'package:filmax/domain/entities/movie.dart';
import 'package:filmax/domain/usecases/get_list_movie_popular.dart';
import 'package:filmax/presentation/bloc/moviepopular/bloc.dart';

// part '../bloc/movie_popular_event.dart';
// part '../bloc/movie_popular_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  // MoviePopularBloc() : super(MoviePopularInitial());

  // final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetListMoviePopular getPopular;
  // final InputConverter inputConverter;

  MoviePopularBloc({
    // required GetConcreteNumberTrivia concrete,
    required GetListMoviePopular popular,
    // required this.inputConverter,
  })  :
        // getConcreteNumberTrivia = concrete,
        getPopular = popular,
        super(Empty()) {
    initialState;
  }

  MoviePopularState get initialState => Empty();

  @override
  Stream<MoviePopularState> mapEventToState(
    MoviePopularEvent event,
  ) async* {
    // if (event is GetTriviaForConcreteNumber) {
    //   final inputEither =
    //   inputConverter.stringToUnsignedInteger(event.numberString);
    //
    //   yield* inputEither.fold(
    //         (failure) async* {
    //       yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
    //     },
    //         (integer) async* {
    //       yield Loading();
    //       final failureOrTrivia =
    //       await getConcreteNumberTrivia(Params(number: integer));
    //       yield* _eitherLoadedOrErrorState(failureOrTrivia);
    //     },
    //   );
    // } else
    if (event is GetDataForPopular) {
      yield Loading();
      final failureOrLoaded = await getPopular(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrLoaded);
    }
  }

  Stream<MoviePopularState> _eitherLoadedOrErrorState(
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
