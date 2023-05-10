import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibr/pages/page_state.dart';
import 'package:vibr/player/player_cubit.dart';

import '../models/models.dart';
import '../pages/page_cubit.dart';
import '../pages/pages.dart';
import '../widgets/navigation_item.dart';
import '../widgets/small_horizontal_player.dart';

class MobileScaffold extends StatelessWidget {
  const MobileScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((PageCubit cubit) => cubit.state);
    final currentTrack =
        context.select((PlayerCubit cubit) => cubit.state.currentTrack);
    final badgeColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      appBar: AppBar(
        title: Text(state.current.title),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Badge(
                backgroundColor: badgeColor,
                child: const Icon(Icons.account_circle_outlined),
              ))
        ],
      ),
      body: state.current.builder(),
      bottomNavigationBar: _buildNavBar(context, currentTrack, state),
    );
  }

  Column _buildNavBar(
      BuildContext context, Track? currentTrack, PageState state) {
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
