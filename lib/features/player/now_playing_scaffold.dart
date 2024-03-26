import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'now_playing.dart';
import 'player_cubit.dart';

class NowPlayingScaffold extends StatelessWidget {
  const NowPlayingScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final track =
        context.select((PlayerCubit cubit) => cubit.state.currentTrack);
    return Scaffold(
      appBar: AppBar(title: const Text('Now Playing')),
      body: track == null
          ? const Center(child: Text('No current track'))
          : NowPlaying(track),
    );
  }
}
