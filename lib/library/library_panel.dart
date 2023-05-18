import 'package:flutter/material.dart';
import 'package:vibr/routes.dart';
import 'package:vibr/theme.dart';

import '../scroll.dart';

class LibraryPanel extends StatelessWidget {
  const LibraryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: scrollPhysics,
      children: [
        const SizedBox(height: 32),
        ListTile(
          title: Text('Artists', style: context.text().headlineLarge),
          onTap: () => ArtistsRoute().push(context),
        ),
        ListTile(
          title: Text('Songs', style: context.text().headlineLarge),
          onTap: () => SongsRoute().push(context),
        ),
        ListTile(
          title: Text('Albums', style: context.text().headlineLarge),
          onTap: () => AlbumsRoute().push(context),
        ),
        ListTile(
          title: Text('Playlists', style: context.text().headlineLarge),
        ),
      ],
    );
  }
}
