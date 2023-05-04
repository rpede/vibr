import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app_state.dart';
import 'color_schemes.g.dart';
import 'scaffolds/app_scaffold.dart';
import 'scroll_wrapper.dart';

void main() {
  runApp(VibrApp());
}

const headlineFont = 'Audiowide';

class VibrApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        /* Color scheme build with:
          - https://www.canva.com/colors/color-wheel/
          - https://m3.material.io/theme-builder#/custom
        */
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontFamily: headlineFont),
            headlineMedium: TextStyle(fontFamily: headlineFont),
            headlineSmall: TextStyle(fontFamily: headlineFont),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontFamily: headlineFont),
            headlineMedium: TextStyle(fontFamily: headlineFont),
            headlineSmall: TextStyle(fontFamily: headlineFont),
          ),
        ),
        builder: (context, child) => ResponsiveWrapper.builder(
          StretchingScrollWrapper.builder(context, child!),
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(350, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1400, name: DESKTOP),
          ],
        ),
        home: const AppScaffold(),
      ),
    );
  }
}
