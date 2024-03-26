import 'package:flutter/material.dart';
import '../../core/models/track.dart';
import 'large_player.dart';
import '../../common/lyric.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying(this.track, {super.key});

  final Track track;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [LargePlayer(track), const Lyrics()]);
  }
}
