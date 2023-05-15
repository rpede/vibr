import 'package:flutter/material.dart';
import 'package:vibr/theme.dart';

import '../scroll.dart';
import 'album_list_scaffold.dart';
import 'artist_list_scaffold.dart';
import 'song_list_scaffold.dart';

class LibraryPanel extends StatelessWidget {
  LibraryPanel({super.key});

  final items = {
    'Artists': ArtistListScaffold.new,
    'Songs': SongListScaffold.new,
    'Albums': AlbumListScaffold.new,
    'Playlists': null,
  };

  @override
  Widget build(BuildContext context) {
    final textStyle = context.text().headlineLarge;
    return ListView(
      physics: scrollPhysics,
      children: [
        SizedBox(height: 32),
        for (final item in items.entries)
          ListTile(
            title: Text(item.key, style: textStyle),
            onTap: () {
              if (item.value != null) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => item.value!(),
                ));
              }
            },
          ),
      ],
    );
  }
}
