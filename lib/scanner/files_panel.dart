import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datasources/isar_datasource.dart';
import '../player/player_cubit.dart';
import '../scroll.dart';

class FilesPanel extends StatelessWidget {
  const FilesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<IsarDataSource>();
    return StreamBuilder(
      stream: db.watchTracks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(physics: scrollPhysics, children: [
          for (final track in snapshot.data!)
            ListTile(
              title: Text("${track.title} - ${track.artist}"),
              subtitle: Text(track.source),
              trailing: Text(track.format?.type ?? 'Unknown'),
              onTap: () {
                context.read<PlayerCubit>().add(track);
              },
            )
        ]);
      },
    );
  }
}
