import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibr/scroll.dart';
import 'package:vibr/widgets/track_tile.dart';

import '../player/player_cubit.dart';

class QueuePanel extends StatelessWidget {
  const QueuePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final queue = context.select((PlayerCubit player) => player.state.queue);
    return ReorderableListView(
      physics: scrollPhysics,
      onReorder: (oldIndex, newIndex) =>
          context.read<PlayerCubit>().moveInQueue(oldIndex, newIndex),
      children: queue
          .asMap()
          .entries
          .map((e) => TrackTile(
                e.value,
                onTap: () => context.read<PlayerCubit>().playFromQueue(e.key),
              ))
          .toList(),
    );
  }
}
