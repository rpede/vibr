import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibr/theme.dart';
import 'package:vibr/widgets/cover_image.dart';

import '../models/models.dart';
import '../player/player_cubit.dart';

class QueueTile extends StatelessWidget {
  final QueuedTrack queuedTrack;
  final int index;
  QueueTile(this.queuedTrack, {required this.index})
      : super(key: Key(queuedTrack.queueId));

  @override
  Widget build(BuildContext context) {
    final selected =
        context.select((PlayerCubit player) => player.state.index) == index;
    final track = queuedTrack.track;
    return Dismissible(
      key: Key('dismissible-${queuedTrack.queueId}'),
      background: Container(color: Colors.red),
      onDismissed: (direction) => context.read<PlayerCubit>().remove(index),
      child: ListTile(
        onTap: () => context.read<PlayerCubit>().playFromQueue(index),
        leading: SizedBox(
          width: 50,
          height: 50,
          child: CoverImage(track.image),
        ),
        title: Text(track.title),
        subtitle: Text(track.artist),
        trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        tileColor: selected ? context.color().primaryContainer : null,
      ),
    );
  }
}
