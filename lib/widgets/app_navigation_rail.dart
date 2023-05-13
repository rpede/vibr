import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibr/player/player_cubit.dart';

import '../models/models.dart';
import '../pages/page_cubit.dart';
import '../pages/pages.dart';
import '../player/small_vertical_player.dart';

class AppNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final bool showPlayer;
  final bool extended;
  final void Function(int index) onDestinationSelected;

  const AppNavigationRail(
      {super.key,
      required this.selectedIndex,
      required this.onDestinationSelected,
      required this.showPlayer,
      required this.extended});

  @override
  Widget build(BuildContext context) {
    final currentTrack =
        context.select((PlayerCubit cubit) => cubit.state.currentTrack);
    return LayoutBuilder(
      builder: (context, constraint) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: NavigationRail(
              useIndicator: false,
              selectedIndex: selectedIndex,
              groupAlignment: -1.0,
              onDestinationSelected: onDestinationSelected,
              destinations: [
                for (final page in pages)
                  _buildNavigationRailDestination(context, page)
              ],
              extended: extended,
              trailing: showPlayer && currentTrack != null
                  ? _buildPlayer(currentTrack, extended)
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
