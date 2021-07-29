part of 'rate_movie_bloc.dart';

abstract class RateMovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDataForRateMovie extends RateMovieEvent {
  final String idMovie;
  final String guestId;
  final String sessionId;

  GetDataForRateMovie(
      {required this.idMovie, required this.guestId, required this.sessionId});

  @override
  List<Object> get props => [idMovie, guestId, sessionId];
}

class GetDataForRateMovieReset extends RateMovieEvent {}
