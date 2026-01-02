import 'package:equatable/equatable.dart';

/// Base failure class for functional error handling with dartz.
abstract class Failure extends Equatable {
  const Failure({this.message = 'An error occurred'});

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Failure for server-related errors.
class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error occurred'});
}

/// Failure for network-related errors.
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection'});
}

/// Failure for cache-related errors.
class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error occurred'});
}

/// Failure for authentication-related errors.
class AuthFailure extends Failure {
  const AuthFailure({super.message = 'Authentication failed'});
}

/// Failure for validation-related errors.
class ValidationFailure extends Failure {
  const ValidationFailure({
    super.message = 'Validation failed',
    this.errors = const {},
  });

  final Map<String, List<String>> errors;

  @override
  List<Object?> get props => [message, errors];
}

/// Failure for unknown errors.
class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'An unknown error occurred'});
}
