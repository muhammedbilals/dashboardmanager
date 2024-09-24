import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  const Failure([List properties = const <dynamic>[]]) : super();
}
///server Failure
//Can be used when trying to fetch data from backend
///


class ConnectionFailure extends Failure {
  final String errorMessage = 'Connection to the server failed';

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'ConnectionFailure{errorMessage: $errorMessage}';
  }
}

class ServerFailure extends Failure {
  final String errorMessage;

  const ServerFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'ServerFailure{errorMessage: $errorMessage}';
  }
}

class CacheFailure extends Failure {
  final String errorMessage;

  const CacheFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'CacheFailure{errorMessage: $errorMessage}';
  }
}