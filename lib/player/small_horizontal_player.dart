import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/models.dart';
import 'now_playing_scaffold.dart';
import 'playback_controls.dart';

class SmallHorizontalPlayer extends StatelessWidget {
  const SmallHorizontalPlayer(this.track, {super.key});
  final Track track;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(NowPlayingScaffold.path);
      },
      leading: SizedBox(
        height: 50,
        width: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:
              track.image != null ? Image.asset(track.image!) : Placeholder(),
        ),
      ),
      title: Text(track.title),
      subtitle: Text(track.artist),
      trailing: PlaybackControls(size: 24),
    );
  }
}
