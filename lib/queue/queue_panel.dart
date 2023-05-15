import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../player/player_cubit.dart';
import '../scroll.dart';
import 'queue_tile.dart';

class QueuePanel extends StatelessWidget {
  const QueuePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((PlayerCubit player) => player.state);
    return ReorderableListView(
      physics: scrollPhysics,
      onReorder: (oldIndex, newIndex) =>
          context.read<PlayerCubit>().moveInQueue(oldIndex, newIndex),
      children: state.queue
          .asMap()
          .entries
          .map((e) => QueueTile(index: e.key, e.value))
          .toList(),
    );
  }
}
