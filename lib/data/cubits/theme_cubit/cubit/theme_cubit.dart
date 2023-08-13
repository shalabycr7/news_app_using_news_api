import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit(bool initialThemeValue) : super(initialThemeValue);

  void toggleTheme() {
    emit(!state);
  }

  factory ThemeCubit.fromSystemBrightness() {
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;
    return ThemeCubit(brightness == Brightness.dark);
  }
}
