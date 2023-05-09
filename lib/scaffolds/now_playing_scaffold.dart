import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cubit/app_cubit.dart';
import '../panels/now_playing.dart';

class NowPlayingScaffold extends StatelessWidget {
  const NowPlayingScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final track = context.select((AppCubit cubit) => cubit.state.currentTrack);
    return Scaffold(
      appBar: AppBar(title: const Text('Now Playing')),
      body: track == null
          ? Center(child: Text('No current track'))
          : NowPlaying(track),
    );
  }
}
