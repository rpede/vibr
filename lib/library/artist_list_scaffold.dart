import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datasources/isar_datasource.dart';
import '../player/player_cubit.dart';
import '../scroll.dart';
import 'artist_scaffold.dart';

class ArtistListScaffold extends StatelessWidget {
  const ArtistListScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<IsarDataSource>();
    return Scaffold(
      appBar: AppBar(title: Text('Songs')),
      body: FutureBuilder(
        future: db.getArtists(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return ListView(physics: scrollPhysics, children: [
            for (final artist in snapshot.data!)
              ListTile(
                title: Text(artist),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArtistScaffold(artist),
                )),
                onLongPress: () async {
                  final tracks = await db.getTracksByArtist(artist);
                  context.read<PlayerCubit>().addAll(tracks);
                },
              )
          ]);
        },
      ),
    );
  }
}
