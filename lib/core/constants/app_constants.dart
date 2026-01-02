/// Application-wide constants.
abstract class AppConstants {
  /// Application name.
  static const String appName = 'MST Test App';

  /// Storage keys.
  static const String themeKey = 'app_theme';
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';

  /// Animation durations.
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  /// Pagination.
  static const int defaultPageSize = 20;

  /// Debounce durations.
  static const Duration searchDebounce = Duration(milliseconds: 500);
}
