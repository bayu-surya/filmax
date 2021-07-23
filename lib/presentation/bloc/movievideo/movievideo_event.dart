part of 'movievideo_bloc.dart';

abstract class MovievideoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDataForMovievideo extends MovievideoEvent {
  final String id;

  GetDataForMovievideo(this.id);

  @override
  List<Object> get props => [id];
}
