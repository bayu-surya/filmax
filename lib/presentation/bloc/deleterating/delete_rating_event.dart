part of 'delete_rating_bloc.dart';

abstract class DeleteRatingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDataForDelete extends DeleteRatingEvent {
  final String idMovie;
  final String guestId;
  final String sessionId;

  GetDataForDelete(
      {required this.idMovie, required this.guestId, required this.sessionId});

  @override
  List<Object> get props => [idMovie, guestId, sessionId];
}

class GetDataForDeleteReset extends DeleteRatingEvent {}
