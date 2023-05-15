import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vibr/scanner/files_panel.dart';

import '../library/library_panel.dart';
import '../prototype/explore_panel.dart';
import '../prototype/search_panel.dart';
import '../prototype/home_panel.dart';
import '../scanner/scanner_panel.dart';

class AppPage extends Equatable {
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

  @override
  List<Object?> get props => [title, icon, selectedIcon];
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
  AppPage(
    title: 'Scan',
    builder: ScannerPanel.new,
    icon: Icons.radar_outlined,
    selectedIcon: Icons.radar,
  ),
];
