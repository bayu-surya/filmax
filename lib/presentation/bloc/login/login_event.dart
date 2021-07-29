part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDataForLogin extends LoginEvent {
  final Login login;

  GetDataForLogin(this.login);

  @override
  List<Object> get props => [login];
}
