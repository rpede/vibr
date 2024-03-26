import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/models/models.dart';
import '../routing/pages.dart';
import '../features/player/player_cubit.dart';
import '../features/player/small_vertical_player.dart';

class AppNavigationRail extends StatefulWidget {
  final bool showPlayer;
  final bool extended;

  const AppNavigationRail({
    super.key,
    required this.showPlayer,
    required this.extended,
  });

  @override
  State<AppNavigationRail> createState() => _AppNavigationRailState();
}

class _AppNavigationRailState extends State<AppNavigationRail> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = pages.indexWhere((page) => location.startsWith(page.path));
    if (index != -1) _selectedIndex = index;
    final currentTrack =
        context.select((PlayerCubit cubit) => cubit.state.currentTrack);
    return LayoutBuilder(
      builder: (context, constraint) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: NavigationRail(
              useIndicator: false,
              selectedIndex: _selectedIndex,
              groupAlignment: -1.0,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                pages[index].navigate(context);
              },
              destinations: [
                for (final page in pages)
                  _buildNavigationRailDestination(context, page)
              ],
              extended: widget.extended,
              trailing: widget.showPlayer && currentTrack != null
                  ? _buildPlayer(currentTrack, widget.extended)
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  _buildNavigationRailDestination(BuildContext context, AppPage page) {
    final selectedColor = Theme.of(context).colorScheme.primary;
    final selectedShadows = [Shadow(color: selectedColor, blurRadius: 10.0)];
    return NavigationRailDestination(
      icon: Icon(page.icon),
      selectedIcon: Icon(
        page.selectedIcon,
        color: selectedColor,
        shadows: selectedShadows,
      ),
      label: Text(page.title),
    );
  }

  _buildPlayer(Track track, bool extended) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SmallVerticalPlayer(track, extended: extended),
      ),
    );
  }
}
