part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDataForUser extends UserEvent {
  final User user;

  GetDataForUser({required this.user});

  @override
  List<Object> get props => [user];
}
