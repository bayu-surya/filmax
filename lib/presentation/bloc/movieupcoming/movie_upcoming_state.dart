part of 'movie_upcoming_bloc.dart';

abstract class MovieUpcomingState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends MovieUpcomingState {}

class Loading extends MovieUpcomingState {}

class Loaded extends MovieUpcomingState {
  final List<Movie> data;

  Loaded({required this.data});

  @override
  List<Object> get props => [data];
}

class Error extends MovieUpcomingState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
