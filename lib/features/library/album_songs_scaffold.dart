import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/datasources/isar_datasource.dart';
import '../../common/track_tile.dart';

class AlbumSongsScaffold extends StatelessWidget {
  final String? artist;
  final String album;
  const AlbumSongsScaffold({
    super.key,
    required this.artist,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    final db = context.read<IsarDataSource>();
    return FutureBuilder(
      future: db.getTracksByAlbum(artist: artist, album: album),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(children: [
          AppBar(title: Text(album)),
          for (final track in snapshot.data!) TrackTile(track),
        ]);
      },
    );
  }
}
