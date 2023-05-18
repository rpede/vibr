import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datasources/isar_datasource.dart';
import '../scroll.dart';
import '../widgets/track_tile.dart';

class SongListScaffold extends StatelessWidget {
  const SongListScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<IsarDataSource>();
    return FutureBuilder(
      future: db.getTracks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return ListView(
          physics: scrollPhysics,
          children:
              (snapshot.data ?? []).map((track) => TrackTile(track)).toList(),
        );
      },
    );
  }
}
