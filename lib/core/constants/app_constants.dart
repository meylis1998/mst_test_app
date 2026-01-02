abstract class AppConstants {
  static const String appName = 'MST Test App';

  static const String themeKey = 'app_theme';
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';

  static const String onboardingCompletedKey = 'onboarding_completed';

  static const String subscriptionStatusKey = 'subscription_status';
  static const String subscriptionPlanKey = 'subscription_plan';

  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  static const int defaultPageSize = 20;

  static const Duration searchDebounce = Duration(milliseconds: 500);
}
