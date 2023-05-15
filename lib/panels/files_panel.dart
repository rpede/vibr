import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vibr/player/player_cubit.dart';
import 'package:vibr/scroll.dart';

import '../datasources/filesystem_datasource.dart';
import '../datasources/isar_datasource.dart';
import '../models/track.dart';

class FilesPanel extends StatefulWidget {
  const FilesPanel({super.key});

  @override
  State<FilesPanel> createState() => _FilesPanelState();
}

class _FilesPanelState extends State<FilesPanel> {
  late IsarDataSource _db;

  @override
  void initState() {
    _db = context.read<IsarDataSource>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _db.watchTracks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return ListView(
          physics: scrollPhysics,
          children: (snapshot.data ?? [])
              .map((track) => ListTile(
                    title: Text(track.title),
                    subtitle: Text(track.artist),
                    trailing: Text(track.format?.type ?? 'Unknown'),
                    onTap: () {
                      context.read<PlayerCubit>().add(track);
                    },
                  ))
              .toList(),
        );
      },
    );
  }
}
