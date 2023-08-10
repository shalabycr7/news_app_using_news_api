import 'package:flutter/material.dart';

var darkTheme = ThemeData.from(colorScheme: darkColorScheme);
var lightTheme = ThemeData.from(colorScheme: lightColorScheme);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFBF0022),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFFFDAD7),
  onPrimaryContainer: Color(0xFF410005),
  secondary: Color(0xFFA8372C),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFFFDAD5),
  onSecondaryContainer: Color(0xFF410001),
  tertiary: Color(0xFFBF0022),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFDAD7),
  onTertiaryContainer: Color(0xFF410005),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFFFBFF),
  onBackground: Color(0xFF201A1A),
  surface: Color(0xFFFFFBFF),
  onSurface: Color(0xFF201A1A),
  surfaceVariant: Color(0xFFF4DDDB),
  onSurfaceVariant: Color(0xFF534342),
  outline: Color(0xFF857371),
  onInverseSurface: Color(0xFFFBEEEC),
  inverseSurface: Color(0xFF362F2E),
  inversePrimary: Color(0xFFFFB3AF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFBF0022),
  outlineVariant: Color(0xFFD8C1C0),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFFFB3AF),
  onPrimary: Color(0xFF68000D),
  primaryContainer: Color(0xFF930017),
  onPrimaryContainer: Color(0xFFFFDAD7),
  secondary: Color(0xFFFFB4A9),
  onSecondary: Color(0xFF670505),
  secondaryContainer: Color(0xFF871F18),
  onSecondaryContainer: Color(0xFFFFDAD5),
  tertiary: Color(0xFFFFB3AF),
  onTertiary: Color(0xFF68000D),
  tertiaryContainer: Color(0xFF930017),
  onTertiaryContainer: Color(0xFFFFDAD7),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF201A1A),
  onBackground: Color(0xFFEDE0DE),
  surface: Color(0xFF201A1A),
  onSurface: Color(0xFFEDE0DE),
  surfaceVariant: Color(0xFF534342),
  onSurfaceVariant: Color(0xFFD8C1C0),
  outline: Color(0xFFA08C8B),
  onInverseSurface: Color(0xFF201A1A),
  inverseSurface: Color(0xFFEDE0DE),
  inversePrimary: Color(0xFFBF0022),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFFFB3AF),
  outlineVariant: Color(0xFF534342),
  scrim: Color(0xFF000000),
);
