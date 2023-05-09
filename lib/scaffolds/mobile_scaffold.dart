import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cubit/app_cubit.dart';
import '../pages.dart';
import '../widgets/navigation_item.dart';
import '../widgets/small_horizontal_player.dart';

class MobileScaffold extends StatelessWidget {
  const MobileScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    final state = context.select((AppCubit cubit) => cubit.state);
    final badgeColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      appBar: AppBar(
        title: Text(state.currentPage.title),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Badge(
                backgroundColor: badgeColor,
                child: const Icon(Icons.account_circle_outlined),
              ))
        ],
      ),
      body: state.currentPage.builder(),
      bottomNavigationBar: _buildNavigationBar(cubit),
    );
  }

  _buildNavigationBar(AppCubit cubit) {
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

  NavigationItem _buildNavigationItem(AppCubit cubit, AppPage page, int index) {
    return NavigationItem(
      selected: cubit.state.pageIndex == index,
      icon: page.icon,
      selectedIcon: page.selectedIcon,
      onPressed: () => cubit.setPageIndex(index),
    );
  }
}
