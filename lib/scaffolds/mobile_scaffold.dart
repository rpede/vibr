import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/page_cubit.dart';
import '../pages/pages.dart';
import '../widgets/navigation_item.dart';
import '../widgets/small_horizontal_player.dart';

class MobileScaffold extends StatelessWidget {
  const MobileScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PageCubit>();
    final state = context.select((PageCubit cubit) => cubit.state);
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
      bottomNavigationBar: _buildNavigationBar(cubit),
    );
  }

  _buildNavigationBar(PageCubit cubit) {
    final track = cubit.state.currentTrack;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (track != null) SmallHorizontalPlayer(track),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: pages.asMap().entries.map((e) {
            return _buildNavigationItem(cubit, e.value, e.key);
          }).toList(),
        ),
      ],
    );
  }

  NavigationItem _buildNavigationItem(
      PageCubit cubit, AppPage page, int index) {
    return NavigationItem(
      selected: cubit.state.index == index,
      icon: page.icon,
      selectedIcon: page.selectedIcon,
      onPressed: () => cubit.setIndex(index),
    );
  }
}
