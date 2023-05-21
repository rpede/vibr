import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datasources/isar_datasource.dart';
import '../scroll.dart';
import 'album_tile.dart';

class AlbumListScaffold extends StatelessWidget {
  final double spacing = 16;
  const AlbumListScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<IsarDataSource>();
    return FutureBuilder(
      future: db.getAlbums(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return GridView.count(
          physics: scrollPhysics,
          crossAxisCount: _getCrossAxisCount(context),
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          padding: EdgeInsets.symmetric(horizontal: spacing),
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
    return count < 2 ? 2 : count;
  }
}
