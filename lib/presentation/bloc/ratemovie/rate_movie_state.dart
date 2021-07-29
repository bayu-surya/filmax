part of 'rate_movie_bloc.dart';

abstract class RateMovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends RateMovieState {}

class Loading extends RateMovieState {}

class Loaded extends RateMovieState {
  final Rate data;

  Loaded({required this.data});

  @override
  List<Object> get props => [data];
}

class Error extends RateMovieState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
