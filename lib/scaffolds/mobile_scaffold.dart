import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../pages.dart';
import '../widgets/navigation_item.dart';
import '../widgets/small_horizontal_player.dart';

class MobileScaffold extends StatelessWidget {
  const MobileScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
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
      bottomNavigationBar: _buildNavigationBar(state),
    );
  }

  _buildNavigationBar(AppState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SmallHorizontalPlayer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: pages.asMap().entries.map((e) {
            return _buildNavigationItem(state, e.value, e.key);
          }).toList(),
        ),
      ],
    );
  }

  NavigationItem _buildNavigationItem(AppState state, AppPage page, int index) {
    return NavigationItem(
      selected: state.selectedIndex == index,
      icon: page.icon,
      selectedIcon: page.selectedIcon,
      onPressed: () => state.selectedIndex = index,
    );
  }
}
