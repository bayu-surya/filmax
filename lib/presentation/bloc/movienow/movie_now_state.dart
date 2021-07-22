part of 'movie_now_bloc.dart';

abstract class MovieNowState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends MovieNowState {}

class Loading extends MovieNowState {}

class Loaded extends MovieNowState {
  final List<Movie> data;

  Loaded({required this.data});

  @override
  List<Object> get props => [data];
}

class Error extends MovieNowState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
