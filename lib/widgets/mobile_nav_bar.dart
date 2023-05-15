import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/page_cubit.dart';
import '../pages/pages.dart';
import '../player/player_cubit.dart';
import '../player/small_horizontal_player.dart';
import 'navigation_item.dart';

class MobileNavBar extends StatelessWidget {
  const MobileNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((PageCubit cubit) => cubit.state);
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
              selected: state.index == index,
              icon: page.icon,
              selectedIcon: page.selectedIcon,
              onPressed: () {
                context.read<PageCubit>().setIndex(index);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}