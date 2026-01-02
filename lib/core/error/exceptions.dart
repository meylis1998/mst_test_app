class ServerException implements Exception {
  const ServerException({this.message, this.statusCode});

  final String? message;
  final int? statusCode;

  @override
  String toString() =>
      'ServerException(message: $message, statusCode: $statusCode)';
}

class NetworkException implements Exception {
  const NetworkException({this.message = 'No internet connection'});

  final String message;

  @override
  String toString() => 'NetworkException(message: $message)';
}

class CacheException implements Exception {
  const CacheException({this.message = 'Cache not found'});

  final String message;

  @override
  String toString() => 'CacheException(message: $message)';
}

class ValidationException implements Exception {
  const ValidationException({required this.errors});

  final Map<String, List<String>> errors;

  @override
  String toString() => 'ValidationException(errors: $errors)';
}
