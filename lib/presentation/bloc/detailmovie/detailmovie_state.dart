part of 'detailmovie_bloc.dart';

abstract class DetailmovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends DetailmovieState {}

class Loading extends DetailmovieState {}

class Loaded extends DetailmovieState {
  final DetailMovie data;

  Loaded({required this.data});

  @override
  List<Object> get props => [data];
}

class Error extends DetailmovieState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
