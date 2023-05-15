import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datasources/isar_datasource.dart';
import '../models/models.dart';
import '../scroll.dart';
import '../widgets/track_tile.dart';

class AlbumSongScaffold extends StatelessWidget {
  final Album album;
  const AlbumSongScaffold(this.album, {super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<IsarDataSource>();
    return Scaffold(
      appBar: AppBar(title: Text(album.name)),
      body: FutureBuilder(
        future: db.getTracksByAlbum(album),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return ListView(
              physics: scrollPhysics,
              children: [for (final track in snapshot.data!) TrackTile(track)]);
        },
      ),
    );
  }
}
