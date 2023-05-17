import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibr/theme.dart';

import '../scroll.dart';
import 'album_list_scaffold.dart';
import 'artist_list_scaffold.dart';
import 'song_list_scaffold.dart';

class LibraryPanel extends StatelessWidget {
  static const title = 'Library';
  static const path = '/library';

  LibraryPanel({super.key});

  final items = {
    'Artists': ArtistListScaffold.path,
    'Songs': SongListScaffold.path,
    'Albums': AlbumListScaffold.path,
    'Playlists': null,
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: scrollPhysics,
      children: [
        const SizedBox(height: 32),
        for (final item in items.entries)
          ListTile(
            title: Text(item.key, style: context.text().headlineLarge),
            onTap: () {
              if (item.value != null) {
                context.push('${LibraryPanel.path}/${item.value}');
              }
            },
          ),
      ],
    );
  }
}
