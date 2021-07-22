// part of 'movie_popular_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MoviePopularEvent extends Equatable {
  // const MoviePopularEvent();

  @override
  List<Object> get props => [];
}

// class GetTriviaForConcreteNumber extends NumberTriviaEvent {
//   final String numberString;
//
//   GetTriviaForConcreteNumber(this.numberString);
//
//   @override
//   List<Object> get props => [numberString];
// }

class GetDataForPopular extends MoviePopularEvent {}
