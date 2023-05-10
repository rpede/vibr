import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibr/models/track.dart';
import '../scaffolds/now_playing_scaffold.dart';
import 'playback_controls.dart';

class SmallVerticalPlayer extends StatelessWidget {
  const SmallVerticalPlayer(this.track, {super.key, this.extended = false});

  final Track track;
  final bool extended;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (!extended) ...[
        RotatedBox(
          quarterTurns: -1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(track.title), Text(track.artist)],
          ),
        ),
        const SizedBox(height: 6),
      ],
      GestureDetector(
        child: !extended
            ? _buildImage(track)
            : Column(children: [
                _buildImage(track),
                Text(track.title),
                Text(track.artist),
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

  Widget _buildImage(Track track) {
    final double size = extended ? 150 : 75;
    return SizedBox(
      height: size,
      width: size,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:
              track.image != null ? Image.asset(track.image!) : Placeholder()),
    );
  }
}
