part of 'review_bloc.dart';

abstract class ReviewState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends ReviewState {}

class Loading extends ReviewState {}

class Loaded extends ReviewState {
  final List<Review> data;

  Loaded({required this.data});

  @override
  List<Object> get props => [data];
}

class Error extends ReviewState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
