import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datasources/isar_datasource.dart';
import '../scroll.dart';
import 'album_tile.dart';

class ArtistScaffold extends StatelessWidget {
  static const path = 'artist';
  final double spacing = 10;
  final String artist;

  const ArtistScaffold(this.artist, {super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<IsarDataSource>();
    return FutureBuilder(
      future: db.getAlbumsByArtist(artist),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return GridView.count(
          physics: scrollPhysics,
          crossAxisCount: _getCrossAxisCount(context),
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          padding: EdgeInsets.all(spacing),
          children: [
            for (final album in snapshot.data!) AlbumTile(album: album)
          ],
        );
      },
    );
  }

  _getCrossAxisCount(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final count = width ~/ 200;
    return count == 0 ? 1 : count;
  }
}
