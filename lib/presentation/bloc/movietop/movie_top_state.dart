part of 'movie_top_bloc.dart';

@immutable
abstract class MovieTopState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends MovieTopState {}

class Loading extends MovieTopState {}

class Loaded extends MovieTopState {
  final List<Movie> data;

  Loaded({required this.data});

  @override
  List<Object> get props => [data];
}

class Error extends MovieTopState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
