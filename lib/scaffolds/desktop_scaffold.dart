import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/player/large_player.dart';
import '../features/player/player_cubit.dart';
import '../common/app_navigation_rail.dart';
import '../common/lyric.dart';
import '../common/navigator_controls.dart';

class DesktopScaffold extends StatelessWidget {
  final Widget body;

  const DesktopScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final currentTrack =
        context.select((PlayerCubit cubit) => cubit.state.currentTrack);
    final badgeColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
        appBar: AppBar(
          leading: const NavigationControls(),
          title: const Text('Vibr'),
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
            const AppNavigationRail(extended: true, showPlayer: false),
            Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: body,
                    ),
                  ),
                )),
            if (currentTrack != null)
              Flexible(
                flex: 1,
                child: ListView(
                  children: [
                    LargePlayer(currentTrack),
                    const Lyrics(),
                  ],
                ),
              ),
          ],
        ));
  }
}
