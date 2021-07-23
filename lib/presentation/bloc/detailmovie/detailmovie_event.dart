part of 'detailmovie_bloc.dart';

abstract class DetailmovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDataForDetailmovie extends DetailmovieEvent {
  final String id;

  GetDataForDetailmovie(this.id);

  @override
  List<Object> get props => [id];
}
