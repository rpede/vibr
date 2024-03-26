import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/datasources/isar_datasource.dart';
import '../player/player_cubit.dart';
import '../../routing/routes.dart';
import '../../scroll.dart';

class ArtistListScaffold extends StatelessWidget {
  const ArtistListScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<IsarDataSource>();
    final player = context.read<PlayerCubit>();
    return FutureBuilder(
      future: db.getArtists(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(physics: scrollPhysics, children: [
          for (final artist in snapshot.data!)
            ListTile(
              title: Text(artist),
              onTap: () => ArtistRoute(artist).push(context),
              onLongPress: () async {
                final tracks = await db.getTracksByArtist(artist);
                player.addAll(tracks);
              },
            )
        ]);
      },
    );
  }
}
