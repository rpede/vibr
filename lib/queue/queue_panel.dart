import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../player/player_cubit.dart';
import '../player/player_state.dart';
import '../scaffolds/app_scaffold.dart';
import '../scroll.dart';
import 'queue_tile.dart';

class QueuePanel extends StatelessWidget {
  static const title = 'Queue';

  const QueuePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: title,
      body: BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, state) => ReorderableListView(
          physics: scrollPhysics,
          onReorder: (oldIndex, newIndex) =>
              context.read<PlayerCubit>().moveInQueue(oldIndex, newIndex),
          children: state.queue
              .asMap()
              .entries
              .map((e) => QueueTile(index: e.key, e.value))
              .toList(),
        ),
      ),
    );
  }
}
