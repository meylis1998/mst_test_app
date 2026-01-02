part of 'theme_bloc.dart';

/// State for theme management.
final class ThemeState extends Equatable {
  const ThemeState({
    this.themeMode = ThemeMode.system,
  });

  final ThemeMode themeMode;

  /// Whether the current theme is dark mode.
  bool get isDarkMode => themeMode == ThemeMode.dark;

  /// Whether the current theme is light mode.
  bool get isLightMode => themeMode == ThemeMode.light;

  /// Whether the current theme follows system settings.
  bool get isSystemMode => themeMode == ThemeMode.system;

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [themeMode];
}
