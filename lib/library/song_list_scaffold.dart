import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibr/widgets/track_tile.dart';

import '../datasources/isar_datasource.dart';

class SongListScaffold extends StatelessWidget {
  const SongListScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<IsarDataSource>();
    return Scaffold(
      appBar: AppBar(title: Text('Songs')),
      body: FutureBuilder(
        future: db.getTracks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return ListView(
            physics: ClampingScrollPhysics(),
            children: (snapshot.data ?? [])
                .map((track) => TrackTile(track: track))
                .toList(),
          );
        },
      ),
    );
  }
}
