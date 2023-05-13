import 'package:flutter/material.dart';
import 'package:vibr/library/artist_list_scaffold.dart';
import 'package:vibr/library/song_list_scaffold.dart';
import 'package:vibr/theme.dart';

class LibraryPanel extends StatelessWidget {
  LibraryPanel({super.key});

  final items = {
    'Artists': ArtistListScaffold.new,
    'Songs': SongListScaffold.new,
    'Albums': null,
    'Playlists': null,
  };

  @override
  Widget build(BuildContext context) {
    final textStyle = context.text().headlineLarge;
    return ListView(
      physics: ClampingScrollPhysics(),
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
