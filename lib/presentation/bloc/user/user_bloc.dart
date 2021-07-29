import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filmax/domain/entities/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(Empty()) {
    initialState;
  }

  UserState get initialState => Empty();

  @override
  Stream<UserState> mapEventToState(
    UserEvent data,
  ) async* {
    if (data is GetDataForUser) {
      final user = data.user;
      yield Loaded(data: user);
    }
  }
}
