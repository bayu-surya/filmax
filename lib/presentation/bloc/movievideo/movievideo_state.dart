part of 'movievideo_bloc.dart';

abstract class MovievideoState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends MovievideoState {}

class Loading extends MovievideoState {}

class Loaded extends MovievideoState {
  final List<MovieVideo> data;

  Loaded({required this.data});

  @override
  List<Object> get props => [data];
}

class Error extends MovievideoState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
