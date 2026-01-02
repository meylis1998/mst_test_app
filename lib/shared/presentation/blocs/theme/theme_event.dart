part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

final class ThemeLoadRequested extends ThemeEvent {
  const ThemeLoadRequested();
}

final class ThemeToggled extends ThemeEvent {
  const ThemeToggled();
}

final class ThemeModeChanged extends ThemeEvent {
  const ThemeModeChanged(this.themeMode);

  final ThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}
