import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datasources/isar_datasource.dart';
import '../models/models.dart';
import '../scroll.dart';
import '../widgets/track_tile.dart';

class AlbumSongsScaffold extends StatelessWidget {
  static const path = 'album';
  
  final Album album;
  const AlbumSongsScaffold(this.album, {super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<IsarDataSource>();
    return FutureBuilder(
      future: db.getTracksByAlbum(album),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return ListView(physics: scrollPhysics, children: [
          AppBar(title: Text(album.name)),
          for (final track in snapshot.data!) TrackTile(track),
        ]);
      },
    );
  }
}
