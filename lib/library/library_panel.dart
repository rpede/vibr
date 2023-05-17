import 'package:flutter/material.dart';
import 'package:vibr/theme.dart';

import '../scaffolds/app_scaffold.dart';
import '../scroll.dart';
import 'album_list_scaffold.dart';
import 'artist_list_scaffold.dart';
import 'song_list_scaffold.dart';

class LibraryPanel extends StatelessWidget {
  static const title = 'Library';

  LibraryPanel({super.key});

  final items = {
    'Artists': ArtistListScaffold.new,
    'Songs': SongListScaffold.new,
    'Albums': AlbumListScaffold.new,
    'Playlists': null,
  };

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      title: title,
      body: ListView(
        physics: scrollPhysics,
        children: [
          const SizedBox(height: 32),
          for (final item in items.entries)
            ListTile(
              title: Text(item.key, style: context.text().headlineLarge),
              onTap: () {
                if (item.value != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => item.value!(),
                  ));
                }
              },
            ),
        ],
      ),
    );
  }
}
