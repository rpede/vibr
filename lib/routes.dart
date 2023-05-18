import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibr/home_screen.dart';
import 'package:vibr/library/album_list_scaffold.dart';
import 'package:vibr/library/album_songs_scaffold.dart';
import 'package:vibr/library/artist_list_scaffold.dart';
import 'package:vibr/library/artist_scaffold.dart';
import 'package:vibr/library/library_panel.dart';
import 'package:vibr/library/song_list_scaffold.dart';
import 'package:vibr/queue/queue_panel.dart';
import 'package:vibr/scaffolds/app_scaffold.dart';
import 'package:vibr/scanner/files_panel.dart';
import 'package:vibr/scanner/scanner_panel.dart';

import 'player/now_playing_scaffold.dart';

part 'routes.g.dart';

@TypedShellRoute<ShellRoutes>(routes: [
  TypedGoRoute<HomeScreenRoute>(path: HomeScreenRoute.path),
  TypedGoRoute<LibraryRoute>(path: LibraryRoute.path, routes: [
    TypedGoRoute<AlbumsRoute>(path: AlbumsRoute.path),
    TypedGoRoute<ArtistAlbumRoute>(path: ArtistAlbumRoute.path),
    TypedGoRoute<ArtistsRoute>(path: ArtistsRoute.path),
    TypedGoRoute<ArtistRoute>(path: ArtistRoute.path),
    TypedGoRoute<SongsRoute>(path: SongsRoute.path),
  ]),
  TypedGoRoute<QueueRoute>(path: QueueRoute.path),
  TypedGoRoute<FilesRoute>(path: FilesRoute.path),
  TypedGoRoute<ScannerRoute>(path: ScannerRoute.path),
])
class ShellRoutes extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return ResponsiveScaffold(body: navigator);
  }
}

class HomeScreenRoute extends GoRouteData {
  static const path = '/';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

class LibraryRoute extends GoRouteData {
  static const path = '/library';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LibraryPanel();
  }
}

class AlbumsRoute extends GoRouteData {
  static const path = 'albums';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AlbumListScaffold();
  }
}

class ArtistsRoute extends GoRouteData {
  static const path = 'artists';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ArtistListScaffold();
  }
}

class ArtistRoute extends GoRouteData {
  static const path = 'artist/:artist';
  final String artist;
  const ArtistRoute(this.artist);
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ArtistScaffold(artist);
  }
}

class ArtistAlbumRoute extends GoRouteData {
  static const path = 'album/:album';
  final String? artist;
  final String album;
  const ArtistAlbumRoute({this.artist, required this.album});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AlbumSongsScaffold(artist: artist, album: album);
  }
}

class SongsRoute extends GoRouteData {
  static const path = 'songs';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SongListScaffold();
  }
}

@TypedGoRoute<NowPlayingRoute>(path: '/now-playing')
class NowPlayingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NowPlayingScaffold();
  }
}

class QueueRoute extends GoRouteData {
  static const path = '/queue';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const QueuePanel();
  }
}

class FilesRoute extends GoRouteData {
  static const path = '/files';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FilesPanel();
  }
}

class ScannerRoute extends GoRouteData {
  static const path = '/scanner';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ScannerPanel();
  }
}

// final router = GoRouter(
//   initialLocation: '/',
//   routes: [
//     ShellRoute(
//       routes: [
//         GoRoute(
//           path: '/',
//           builder: (context, state) => HomeScreen(),
//         ),
//         for (final page in pages)
//           GoRoute(
//             path: page.path,
//             builder: (context, state) => page.builder(),
//             routes: page.routes,
//           )
//       ],
//       builder: (context, state, child) {
//         return ResponsiveScaffold(body: child);
//       },
//     ),
//     GoRoute(
//       path: NowPlayingScaffold.path,
//       builder: (context, state) => NowPlayingScaffold(),
//     )
//   ],
// );
