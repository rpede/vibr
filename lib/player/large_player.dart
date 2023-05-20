import 'package:flutter/material.dart';
import 'package:vibr/models/track.dart';
import 'package:vibr/widgets/cover_image.dart';

import 'playback_controls.dart';
import 'playback_slider.dart';

class LargePlayer extends StatelessWidget {
  const LargePlayer(this.song, {super.key});

  final Track song;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(children: [
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CoverImage(song.image),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(song.title, style: textTheme.headlineLarge),
        Text(
          song.artist,
          style: textTheme.headlineMedium,
        ),
        const PlaybackSlider(),
        const PlaybackControls(size: 40),
      ]),
    );
  }
}
