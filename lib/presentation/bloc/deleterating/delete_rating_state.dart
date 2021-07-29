part of 'delete_rating_bloc.dart';

abstract class DeleteRatingState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends DeleteRatingState {}

class Loading extends DeleteRatingState {}

class Loaded extends DeleteRatingState {
  final DeleteRating data;

  Loaded({required this.data});

  @override
  List<Object> get props => [data];
}

class Error extends DeleteRatingState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
