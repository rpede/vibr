import 'package:flutter/material.dart';
import 'package:vibr/routes.dart';
import 'package:vibr/widgets/cover_image.dart';

import '../models/models.dart';
import 'playback_controls.dart';

class SmallHorizontalPlayer extends StatelessWidget {
  const SmallHorizontalPlayer(this.track, {super.key});
  final Track track;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => NowPlayingRoute().push(context),
      leading: SizedBox(
        height: 50,
        width: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CoverImage(track.image)
        ),
      ),
      title: Text(track.title),
      subtitle: Text(track.artist),
      trailing: PlaybackControls(size: 24),
    );
  }
}
