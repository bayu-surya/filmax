part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends LoginState {}

class Loading extends LoginState {}

class Loaded extends LoginState {
  final User data;

  Loaded({required this.data});

  @override
  List<Object> get props => [data];
}

class Error extends LoginState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
