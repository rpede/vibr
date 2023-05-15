import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibr/theme.dart';

import '../models/models.dart';
import '../player/player_cubit.dart';

class QueueTile extends StatelessWidget {
  final Track track;
  final int index;
  final bool selected;
  QueueTile(this.track, {required this.index, required this.selected})
      : super(key: Key('queue-tile-${track.id}'));

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('dismissible-${track.id}'),
      background: Container(color: Colors.red),
      onDismissed: (direction) => context.read<PlayerCubit>().remove(index),
      child: ListTile(
        onTap: () => context.read<PlayerCubit>().playFromQueue(index),
        leading: SizedBox(
          width: 50,
          height: 50,
          child:
              track.image != null ? Image.asset(track.image!) : Placeholder(),
        ),
        title: Text(track.title),
        subtitle: Text(track.artist),
        trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        tileColor: selected ? context.color().primaryContainer : null,
      ),
    );
  }
}
