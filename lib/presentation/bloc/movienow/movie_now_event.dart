part of 'movie_now_bloc.dart';

abstract class MovieNowEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDataForNow extends MovieNowEvent {}
