import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../scaffolds/now_playing_scaffold.dart';
import '../song.dart';
import 'playback_controls.dart';

class SmallVerticalPlayer extends StatelessWidget {
  final bool extended;
  const SmallVerticalPlayer({super.key, this.extended = false});

  @override
  Widget build(BuildContext context) {
    final song = Provider.of<AppState>(context).currentSong;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (!extended) ...[
        RotatedBox(
          quarterTurns: -1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(song.title), Text(song.artist)],
          ),
        ),
        const SizedBox(height: 6),
      ],
      GestureDetector(
        child: !extended
            ? _buildImage(song)
            : Column(children: [
                _buildImage(song),
                Text(song.title),
                Text(song.artist),
              ]),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NowPlayingScaffold(),
          ));
        },
      ),
      PlaybackControls(size: 36, showSkip: extended),
    ]);
  }

  Widget _buildImage(Song song) {
    final double size = extended ? 150 : 75;
    return SizedBox(
      height: size,
      width: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(song.image!),
      ),
    );
  }
}
