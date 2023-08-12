import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(_getInitialThemeValue());

  static bool _getInitialThemeValue() {
    // Retrieve the current system brightness mode
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;

    // Return true for dark theme, false for light theme
    return brightness == Brightness.dark;
  }

  void toggleTheme() {
    emit(!state);
  }
}
