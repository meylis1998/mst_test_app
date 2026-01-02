part of 'theme_bloc.dart';

/// Base class for theme events.
sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load the saved theme preference.
final class ThemeLoadRequested extends ThemeEvent {
  const ThemeLoadRequested();
}

/// Event to toggle between light and dark theme.
final class ThemeToggled extends ThemeEvent {
  const ThemeToggled();
}

/// Event to set a specific theme mode.
final class ThemeModeChanged extends ThemeEvent {
  const ThemeModeChanged(this.themeMode);

  final ThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}
