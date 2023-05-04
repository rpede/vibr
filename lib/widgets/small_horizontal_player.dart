import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../scaffolds/now_playing_scaffold.dart';
import 'playback_controls.dart';

class SmallHorizontalPlayer extends StatelessWidget {
  const SmallHorizontalPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final song = Provider.of<AppState>(context).currentSong;
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NowPlayingScaffold(),
        ));
      },
      leading: SizedBox(
        height: 50,
        width: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(song.image!),
        ),
      ),
      title: Text(song.title),
      subtitle: Text(song.artist),
      trailing: PlaybackControls(size: 24),
    );
  }
}
