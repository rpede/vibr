import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../player/player_cubit.dart';

class TrackTile extends StatelessWidget {
  final Track track;
  final VoidCallback? onTap;
  TrackTile(this.track, {this.onTap}) : super(key: ValueKey(track.id));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap ?? () => context.read<PlayerCubit>().add(track),
      leading: SizedBox(
          width: 50,
          height: 50,
          child:
              track.image != null ? Image.asset(track.image!) : Placeholder()),
      title: Text(track.title),
      subtitle: Text(track.artist),
      trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
    );
  }
}
