import 'package:flutter/material.dart';

/// Shared corner radius for chips, buttons, and cards.
const appRadius = 12.0;

RoundedRectangleBorder appShape({BorderSide side = BorderSide.none}) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(appRadius),
    side: side,
  );
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006C46),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF8FF7BF),
  onPrimaryContainer: Color(0xFF002112),
  secondary: Color(0xFF616200),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE8E870),
  onSecondaryContainer: Color(0xFF1D1D00),
  tertiary: Color(0xFFC00014),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFDAD6),
  onTertiaryContainer: Color(0xFF410002),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  // Soft green page — avoid stark white “islands”.
  surface: Color(0xFFEEF3EE),
  onSurface: Color(0xFF191C1A),
  surfaceContainerLowest: Color(0xFFE6EDE6),
  surfaceContainerLow: Color(0xFFEEF3EE),
  surfaceContainer: Color(0xFFE0E9E0),
  surfaceContainerHigh: Color(0xFFD5E0D5),
  surfaceContainerHighest: Color(0xFFC9D6C9),
  onSurfaceVariant: Color(0xFF404943),
  outline: Color(0xFF707972),
  outlineVariant: Color(0xFFA8B5A9),
  onInverseSurface: Color(0xFFEFF1ED),
  inverseSurface: Color(0xFF2E312E),
  inversePrimary: Color(0xFF73DAA4),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006C46),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF73DAA4),
  onPrimary: Color(0xFF003822),
  primaryContainer: Color(0xFF005233),
  onPrimaryContainer: Color(0xFF8FF7BF),
  secondary: Color(0xFFCCCC57),
  onSecondary: Color(0xFF323200),
  secondaryContainer: Color(0xFF494900),
  onSecondaryContainer: Color(0xFFE8E870),
  tertiary: Color(0xFFFFB4AB),
  onTertiary: Color(0xFF690006),
  tertiaryContainer: Color(0xFF93000C),
  onTertiaryContainer: Color(0xFFFFDAD6),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: Color(0xFF1A1F1B),
  onSurface: Color(0xFFE1E3DF),
  surfaceContainerLowest: Color(0xFF151914),
  surfaceContainerLow: Color(0xFF1A1F1B),
  surfaceContainer: Color(0xFF222722),
  surfaceContainerHigh: Color(0xFF2C322C),
  surfaceContainerHighest: Color(0xFF373D37),
  onSurfaceVariant: Color(0xFFC0C9C1),
  outline: Color(0xFF8A938B),
  outlineVariant: Color(0xFF404943),
  onInverseSurface: Color(0xFF191C1A),
  inverseSurface: Color(0xFFE1E3DF),
  inversePrimary: Color(0xFF006C46),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF73DAA4),
);
