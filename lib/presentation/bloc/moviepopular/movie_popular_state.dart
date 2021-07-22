// part of 'movie_popular_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:filmax/domain/entities/movie.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MoviePopularState extends Equatable {
  // const MoviePopularState();

  @override
  List<Object> get props => [];
}

// class MoviePopularInitial extends MoviePopularState {
//   @override
//   List<Object> get props => [];
// }

class Empty extends MoviePopularState {}

class Loading extends MoviePopularState {}

class Loaded extends MoviePopularState {
  final List<Movie> data;

  Loaded({required this.data});

  @override
  List<Object> get props => [data];
}

class Error extends MoviePopularState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
