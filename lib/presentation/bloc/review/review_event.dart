part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDataForReview extends ReviewEvent {
  final String id;

  GetDataForReview(this.id);

  @override
  List<Object> get props => [id];
}
