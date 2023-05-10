import 'package:flutter/material.dart';
import 'color_schemes.g.dart';
import 'main.dart';

const headlineFont = 'Audiowide';

/* Color scheme build with:
  - https://www.canva.com/colors/color-wheel/
  - https://m3.material.io/theme-builder#/custom
*/
final theme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontFamily: headlineFont),
    headlineMedium: TextStyle(fontFamily: headlineFont),
    headlineSmall: TextStyle(fontFamily: headlineFont),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontFamily: headlineFont),
    headlineMedium: TextStyle(fontFamily: headlineFont),
    headlineSmall: TextStyle(fontFamily: headlineFont),
  ),
);

extension ThemeBuildContextExtension on BuildContext {
  Color colorTertiary() {
    return Theme.of(this).colorScheme.tertiary;
  }
  Color colorTertiaryContainer() {
    return Theme.of(this).colorScheme.tertiaryContainer;
  }
}
