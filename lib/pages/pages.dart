import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibr/library/album_list_scaffold.dart';
import 'package:vibr/library/album_songs_scaffold.dart';
import 'package:vibr/library/artist_list_scaffold.dart';
import 'package:vibr/library/artist_scaffold.dart';
import 'package:vibr/library/song_list_scaffold.dart';
import 'package:vibr/queue/queue_panel.dart';
import 'package:vibr/scanner/files_panel.dart';

import '../library/library_panel.dart';
import '../models/models.dart';
import '../scanner/scanner_panel.dart';

class AppPage extends Equatable {
  final String path;
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final Widget Function() builder;
  final List<RouteBase> routes;

  const AppPage({
    required this.path,
    required this.title,
    required this.icon,
    required this.selectedIcon,
    required this.builder,
    this.routes = const [],
  });

  @override
  List<Object?> get props => [title, icon, selectedIcon];
}

List<AppPage> pages = [
  const AppPage(
    path: '/queue',
    title: QueuePanel.title,
    builder: QueuePanel.new,
    icon: Icons.queue_music_outlined,
    selectedIcon: Icons.queue_music,
  ),
  AppPage(
    path: LibraryPanel.path,
    title: LibraryPanel.title,
    builder: LibraryPanel.new,
    icon: Icons.interests_outlined,
    selectedIcon: Icons.interests,
    routes: [
      GoRoute(
        path: AlbumListScaffold.path,
        builder: (context, state) => const AlbumListScaffold(),
      ),
      GoRoute(
        path: AlbumSongsScaffold.path,
        builder: (context, state) => AlbumSongsScaffold(state.extra as Album),
      ),
      GoRoute(
        path: ArtistListScaffold.path,
        builder: (context, state) => const ArtistListScaffold(),
      ),
      GoRoute(
        path: ArtistScaffold.path,
        builder: (context, state) => ArtistScaffold(state.extra as String),
      ),
      GoRoute(
        path: SongListScaffold.path,
        builder: (context, state) => const SongListScaffold(),
      ),
    ],
  ),
  const AppPage(
    path: '/files',
    title: FilesPanel.title,
    builder: FilesPanel.new,
    icon: Icons.folder_outlined,
    selectedIcon: Icons.folder,
  ),
  const AppPage(
    path: '/scanner',
    title: ScannerPanel.title,
    builder: ScannerPanel.new,
    icon: Icons.radar_outlined,
    selectedIcon: Icons.radar,
  ),
];
