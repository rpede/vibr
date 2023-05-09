import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:vibr/datasources/files_types/flac_info_extractor.dart';
import 'package:vibr/datasources/files_types/mp3_info_extractor.dart';
import 'package:vibr/datasources/isar_datasource.dart';
import 'package:vibr/models/track.dart';

import 'app_state.dart';
import 'color_schemes.g.dart';
import 'datasources/filesystem_datasource.dart';
import 'models/source.dart';
import 'scaffolds/app_scaffold.dart';
import 'scroll_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  runApp(VibrApp(
    db: IsarDataSource(
        await Isar.open([TrackSchema, SourceSchema], directory: dir.path)),
    fs: FilesystemDataSource(
      [
        Mp3InfoExtractor(),
        FlacInfoExtractor(),
      ],
    ),
  ));
}

const headlineFont = 'Audiowide';

class VibrApp extends StatelessWidget {
  final IsarDataSource db;
  final FilesystemDataSource fs;

  VibrApp({required this.db, required this.fs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        Provider.value(value: db),
        Provider.value(value: fs),
      ],
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
