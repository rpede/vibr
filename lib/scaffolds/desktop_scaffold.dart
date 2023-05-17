import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vibr/player/player_cubit.dart';

import '../player/large_player.dart';
import '../widgets/app_navigation_rail.dart';
import '../widgets/lyric.dart';
import '../widgets/navigator_controls.dart';

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
          leading: NavigationControls(),
          title: Text('Vibr'),
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
                    Lyrics(),
                  ],
                ),
              ),
          ],
        ));
  }
}
