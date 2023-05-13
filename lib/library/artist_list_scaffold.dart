import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datasources/isar_datasource.dart';

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
          return ListView(
            physics: ClampingScrollPhysics(),
            children: (snapshot.data ?? [])
                .map((artist) => ListTile(title: Text(artist),))
                .toList(),
          );
        },
      ),
    );
  }
}