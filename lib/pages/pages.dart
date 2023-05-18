import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibr/routes.dart';

class AppPage extends Equatable {
  final String path;
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final void Function(BuildContext context) navigate;
  final List<RouteBase> routes;

  const AppPage({
    required this.path,
    required this.title,
    required this.icon,
    required this.selectedIcon,
    required this.navigate,
    this.routes = const [],
  });

  @override
  List<Object?> get props => [path, icon, selectedIcon];
}

List<AppPage> pages = [
  AppPage(
    path: QueueRoute.path,
    title: 'Queue',
    navigate: (context) => QueueRoute().push(context),
    icon: Icons.queue_music_outlined,
    selectedIcon: Icons.queue_music,
  ),
  AppPage(
    path: LibraryRoute.path,
    title: 'Library',
    navigate: (context) => LibraryRoute().push(context),
    icon: Icons.interests_outlined,
    selectedIcon: Icons.interests,
  ),
  AppPage(
    path: FilesRoute.path,
    title: 'Files',
    navigate: (context) => FilesRoute().push(context),
    icon: Icons.folder_outlined,
    selectedIcon: Icons.folder,
  ),
  AppPage(
    path: ScannerRoute.path,
    title: 'Scanner',
    navigate: (context) => ScannerRoute().push(context),
    icon: Icons.radar_outlined,
    selectedIcon: Icons.radar,
  ),
];
