part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends UserState {}

class Loaded extends UserState {
  final User data;

  Loaded({required this.data});

  @override
  List<Object> get props => [data];
}
