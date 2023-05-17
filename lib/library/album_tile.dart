import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vibr/library/library_panel.dart';

import '../theme.dart';
import '../datasources/isar_datasource.dart';
import '../models/album.dart';
import '../player/player_cubit.dart';
import 'album_songs_scaffold.dart';

class AlbumTile extends StatelessWidget {
  final Album album;

  String? get image => album.image;
  String get title => album.name;
  String? get subTitle => album.artist;

  const AlbumTile({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('${LibraryPanel.path}/${AlbumSongsScaffold.path}', extra: album),
      onLongPress: () async {
        final tracks =
            await context.read<IsarDataSource>().getTracksByAlbum(album);
        context.read<PlayerCubit>().addAll(tracks);
      },
      child: Column(
        children: [
          Expanded(
            child: image != null ? Image.asset(image!) : Placeholder(),
          ),
          Container(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              children: [
                Text(title),
                if (subTitle != null)
                  Text(
                    subTitle!,
                    style: context.text().bodySmall,
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
