import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:vibr/datasources/files_types/flac_info_extractor.dart';
import 'package:vibr/datasources/files_types/mp3_info_extractor.dart';
import 'package:vibr/datasources/isar_datasource.dart';
import 'package:vibr/models/track.dart';
import 'package:vibr/player/player_cubit.dart';
import 'package:vibr/routes.dart';

import 'datasources/filesystem_datasource.dart';
import 'models/source.dart';
import 'theme.dart';
import 'scroll.dart';

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

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class VibrApp extends StatelessWidget {
  final IsarDataSource db;
  final FilesystemDataSource fs;

  VibrApp({required this.db, required this.fs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider.value(value: db),
        RepositoryProvider.value(value: fs),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PlayerCubit())
        ],
        child: MaterialApp.router(
          routerConfig: GoRouter(routes: $appRoutes),
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          theme: theme,
          darkTheme: darkTheme,
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
        ),
      ),
    );
  }
}
