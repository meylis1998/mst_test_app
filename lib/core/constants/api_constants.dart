/// API-related constants.
abstract class ApiConstants {
  /// Base URL for the API.
  static const String baseUrl = 'https://api.example.com';

  /// API version.
  static const String apiVersion = '/v1';

  /// Full API base URL.
  static const String apiBaseUrl = '$baseUrl$apiVersion';

  /// Connection timeout in milliseconds.
  static const int connectTimeout = 30000;

  /// Receive timeout in milliseconds.
  static const int receiveTimeout = 30000;

  /// Send timeout in milliseconds.
  static const int sendTimeout = 30000;

  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String profile = '/user/profile';
}
