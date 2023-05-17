import 'package:go_router/go_router.dart';
import 'package:vibr/library/library_panel.dart';
import 'package:vibr/queue/queue_panel.dart';
import 'package:vibr/scaffolds/app_scaffold.dart';
import 'package:vibr/scanner/files_panel.dart';
import 'package:vibr/scanner/scanner_panel.dart';

import 'pages/pages.dart';
import 'player/now_playing_scaffold.dart';

// final routes = [
//   GoRoute(
//     path: '/queue',
//     builder: (context, state) => QueuePanel(),
//   ),
//   GoRoute(
//     path: '/library',
//     builder: (context, state) => LibraryPanel(),
//   ),
//   GoRoute(
//     path: '/files',
//     builder: (context, state) => FilesPanel(),
//   ),
//   GoRoute(
//     path: '/scanner',
//     builder: (context, state) => ScannerPanel(),
//   )
// ];

final router = GoRouter(
  initialLocation: '/library',
  routes: [
    ShellRoute(
      routes: [
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
