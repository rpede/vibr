import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../routing/pages.dart';
import '../features/player/player_cubit.dart';
import '../features/player/small_horizontal_player.dart';
import 'navigation_item.dart';

class MobileNavBar extends StatelessWidget {
  const MobileNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex =
        pages.indexWhere((page) => location.startsWith(page.path));
    final currentTrack =
        context.select((PlayerCubit cubit) => cubit.state.currentTrack);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (currentTrack != null) SmallHorizontalPlayer(currentTrack),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: pages.asMap().entries.map((e) {
            final index = e.key;
            final page = e.value;
            return NavigationItem(
              selected: selectedIndex == index,
              icon: page.icon,
              selectedIcon: page.selectedIcon,
              onPressed: () => page.navigate(context),
            );
          }).toList(),
        ),
      ],
    );
  }
}
