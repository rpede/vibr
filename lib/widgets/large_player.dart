import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../song.dart';
import 'playback_controls.dart';
import 'playback_slider.dart';

class LargePlayer extends StatelessWidget {
  const LargePlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final song = Provider.of<AppState>(context).currentSong;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(children: [
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child:
                song.image != null ? Image.asset(song.image!) : Placeholder(),
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
