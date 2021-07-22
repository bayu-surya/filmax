part of 'movie_upcoming_bloc.dart';

abstract class MovieUpcomingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDataForUpcoming extends MovieUpcomingEvent {}
