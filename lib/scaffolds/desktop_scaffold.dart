import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibr/cubit/app_cubit.dart';
import 'package:vibr/cubit/app_state.dart';

import '../widgets/app_navigation_rail.dart';
import '../widgets/large_player.dart';
import '../widgets/lyric.dart';

class DesktopScaffold extends StatelessWidget {
  const DesktopScaffold({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppNavigationRail(
              selectedIndex: state.pageIndex,
              onDestinationSelected: (index) {
                context.read<AppCubit>().setPageIndex(index);
              },
              extended: true,
              showPlayer: false,
            ),
            Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: state.currentPage.builder()),
                  ),
                )),
            if (state.currentTrack != null)
              Flexible(
                flex: 1,
                child: ListView(
                  children: [
                    LargePlayer(state.currentTrack!),
                    Lyrics(),
                  ],
                ),
              ),
          ],
        ));
  }
}
