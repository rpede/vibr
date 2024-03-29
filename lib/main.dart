import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/datasources/datasources.dart';
import 'core/models/models.dart';
import 'features/player/player_cubit.dart';
import 'routing/routes.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  runApp(VibrApp(
    db: IsarDataSource(await Isar.open(schemas, directory: dir.path)),
    fs: FilesystemDataSource(),
  ));
}

const headlineFont = 'Audiowide';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class VibrApp extends StatelessWidget {
  final IsarDataSource db;
  final FilesystemDataSource fs;

  const VibrApp({super.key, required this.db, required this.fs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider.value(value: db),
        RepositoryProvider.value(value: fs),
      ],
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => PlayerCubit())],
        child: MaterialApp.router(
          routerConfig: GoRouter(routes: $appRoutes),
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          theme: theme,
          darkTheme: darkTheme,
          builder: (context, child) => ResponsiveBreakpoints.builder(
            // StretchingScrollWrapper.builder(context, child!),
            // defaultScale: true,
            child: child!,
            breakpoints: [
              const Breakpoint(start: 350, end: 800, name: MOBILE),
              const Breakpoint(start: 801, end: 1000, name: TABLET),
              const Breakpoint(start: 1001, end: 1400, name: PHONE),
              const Breakpoint(start: 1401, end: 1920, name: DESKTOP),
            ],
          ),
        ),
      ),
    );
  }
}
