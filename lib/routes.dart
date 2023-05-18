import 'package:go_router/go_router.dart';
import 'package:vibr/home_screen.dart';
import 'package:vibr/library/library_panel.dart';
import 'package:vibr/queue/queue_panel.dart';
import 'package:vibr/scaffolds/app_scaffold.dart';

import 'pages/pages.dart';
import 'player/now_playing_scaffold.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(),
        ),
        for (final page in pages)
          GoRoute(
            path: page.path,
            builder: (context, state) => page.builder(),
            routes: page.routes,
          )
      ],
      builder: (context, state, child) {
        return ResponsiveScaffold(body: child);
      },
    ),
    GoRoute(
      path: NowPlayingScaffold.path,
      builder: (context, state) => NowPlayingScaffold(),
    )
  ],
);
