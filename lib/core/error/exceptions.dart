/// Exception thrown when a server error occurs.
class ServerException implements Exception {
  const ServerException({this.message, this.statusCode});

  final String? message;
  final int? statusCode;

  @override
  String toString() =>
      'ServerException(message: $message, statusCode: $statusCode)';
}

/// Exception thrown when there is no internet connection.
class NetworkException implements Exception {
  const NetworkException({this.message = 'No internet connection'});

  final String message;

  @override
  String toString() => 'NetworkException(message: $message)';
}

/// Exception thrown when cached data is not found.
class CacheException implements Exception {
  const CacheException({this.message = 'Cache not found'});

  final String message;

  @override
  String toString() => 'CacheException(message: $message)';
}

/// Exception thrown when authentication fails.
class AuthException implements Exception {
  const AuthException({this.message = 'Authentication failed'});

  final String message;

  @override
  String toString() => 'AuthException(message: $message)';
}

/// Exception thrown when validation fails.
class ValidationException implements Exception {
  const ValidationException({required this.errors});

  final Map<String, List<String>> errors;

  @override
  String toString() => 'ValidationException(errors: $errors)';
}
