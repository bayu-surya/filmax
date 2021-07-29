import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/core/error/failure.dart';
import 'package:filmax/domain/entities/movie_video.dart';
import 'package:filmax/domain/usecases/get_list_movie_video.dart';

part 'movievideo_event.dart';
part 'movievideo_state.dart';

class MovievideoBloc extends Bloc<MovievideoEvent, MovievideoState> {
  final GetListMovieVideo getVideo;

  MovievideoBloc({
    required GetListMovieVideo video,
  })  : getVideo = video,
        super(Empty()) {
    initialState;
  }

  MovievideoState get initialState => Empty();

  @override
  Stream<MovievideoState> mapEventToState(
    MovievideoEvent event,
  ) async* {
    if (event is GetDataForMovievideo) {
      final input = event.id;
      yield Loading();
      final failureOrLoaded = await getVideo(Params(id: input));
      yield* _eitherLoadedOrErrorState(failureOrLoaded);
    }
  }

  Stream<MovievideoState> _eitherLoadedOrErrorState(
    Either<Failure, List<MovieVideo>> failureOrLoaded,
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
