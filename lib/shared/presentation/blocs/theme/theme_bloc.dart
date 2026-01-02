import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mst_test_app/core/constants/app_constants.dart';
import 'package:mst_test_app/shared/data/datasources/local_storage.dart';

part 'theme_event.dart';
part 'theme_state.dart';

/// BLoC for managing application theme.
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required LocalStorage localStorage})
      : _localStorage = localStorage,
        super(const ThemeState()) {
    on<ThemeLoadRequested>(_onLoadRequested);
    on<ThemeToggled>(_onToggled);
    on<ThemeModeChanged>(_onModeChanged);
  }

  final LocalStorage _localStorage;

  Future<void> _onLoadRequested(
    ThemeLoadRequested event,
    Emitter<ThemeState> emit,
  ) async {
    final savedTheme = _localStorage.getString(AppConstants.themeKey);
    final themeMode = _themeModeFromString(savedTheme);
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> _onToggled(
    ThemeToggled event,
    Emitter<ThemeState> emit,
  ) async {
    final newThemeMode = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    await _saveTheme(newThemeMode);
    emit(state.copyWith(themeMode: newThemeMode));
  }

  Future<void> _onModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    await _saveTheme(event.themeMode);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _saveTheme(ThemeMode themeMode) async {
    await _localStorage.setString(
      AppConstants.themeKey,
      themeMode.name,
    );
  }

  ThemeMode _themeModeFromString(String? value) {
    return switch (value) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }
}
