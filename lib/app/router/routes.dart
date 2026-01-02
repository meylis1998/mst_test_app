/// Route path constants.
abstract class Routes {
  // Root
  static const String initial = '/';

  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Main
  static const String home = '/home';
  static const String settings = '/settings';

  // Feature-specific routes can be added here
  // Example:
  // static const String profile = '/profile';
  // static const String notifications = '/notifications';
}

/// Route name constants (for named navigation).
abstract class RouteNames {
  static const String initial = 'initial';
  static const String login = 'login';
  static const String register = 'register';
  static const String forgotPassword = 'forgot-password';
  static const String home = 'home';
  static const String settings = 'settings';
}
