import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibr/routing/routes.dart';
import 'package:vibr/common/cover_image.dart';

import '../../theme/theme.dart';
import '../../core/datasources/isar_datasource.dart';
import '../../core/models/album.dart';
import '../player/player_cubit.dart';

class AlbumTile extends StatelessWidget {
  final Album album;

  String? get image => album.image;
  String get title => album.name;
  String? get subTitle => album.artist;

  const AlbumTile({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    final player = context.read<PlayerCubit>();
    return InkWell(
      onTap: () =>
          ArtistAlbumRoute(artist: album.artist, album: album.name).push(context),
      onLongPress: () async {
        final tracks = await context
            .read<IsarDataSource>()
            .getTracksByAlbum(album: album.name);
        player.addAll(tracks);
      },
      child: Column(
        children: [
          Expanded(
            child: CoverImage(image),
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
