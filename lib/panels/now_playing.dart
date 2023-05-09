import 'package:flutter/material.dart';
import 'package:vibr/models/track.dart';
import '../widgets/large_player.dart';
import '../widgets/lyric.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying(this.track, {super.key});

  final Track track;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [LargePlayer(track), Lyrics()]);
  }
}
