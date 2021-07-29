import 'package:equatable/equatable.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

// abstract class Failure extends Equatable {
//   // If the subclasses have some properties, they'll get passed to this constructor
//   // so that Equatable can perform value comparison.
//   Failure([List properties = const <dynamic>[]]) : super(properties);
// }

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NoInternetFailure extends Failure {}
