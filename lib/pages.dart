import 'package:flutter/material.dart';
import 'package:vibr/panels/files_panel.dart';

import 'panels/panels.dart';

class AppPage {
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  final Widget Function() builder;

  const AppPage({
    required this.title,
    required this.icon,
    required this.selectedIcon,
    required this.builder,
  });
}

const List<AppPage> pages = [
  AppPage(
    title: 'Home',
    builder: HomePanel.new,
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
  ),
  AppPage(
    title: 'Explore',
    builder: ExplorePanel.new,
    icon: Icons.explore_outlined,
    selectedIcon: Icons.explore,
  ),
  AppPage(
    title: 'Search',
    builder: SearchPanel.new,
    icon: Icons.search_outlined,
    selectedIcon: Icons.search,
  ),
  AppPage(
    title: 'Library',
    builder: LibraryPanel.new,
    icon: Icons.interests_outlined,
    selectedIcon: Icons.interests,
  ),
  AppPage(
    title: 'Files',
    builder: FilesPanel.new,
    icon: Icons.folder_outlined,
    selectedIcon: Icons.folder,
  ),
];
