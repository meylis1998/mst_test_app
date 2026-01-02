abstract class ApiConstants {
  static const String baseUrl = 'https://api.example.com';

  static const String apiVersion = '/v1';

  static const String apiBaseUrl = '$baseUrl$apiVersion';

  static const int connectTimeout = 30000;

  static const int receiveTimeout = 30000;

  static const int sendTimeout = 30000;

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String profile = '/user/profile';
}
