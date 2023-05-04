import 'package:flutter/material.dart';
import '../widgets/large_player.dart';
import '../widgets/lyric.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [LargePlayer(), Lyrics()]);
  }
}
