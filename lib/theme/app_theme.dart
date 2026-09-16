import 'package:flutter/material.dart';

class AppTheme {
  static const Color seed = Color(0xFF1F6F7A);

  static ThemeData get light {
    return _theme(ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    ));
  }

  static ThemeData get dark {
    return _theme(ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    ));
  }

  static ThemeData _theme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorColor: scheme.secondaryContainer,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
