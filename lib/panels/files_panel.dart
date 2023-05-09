import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

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
  late FilesystemDataSource _fs;

  @override
  void initState() {
    _db = context.read<IsarDataSource>();
    _fs = context.read<FilesystemDataSource>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _db.getLocalDataSource(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: ElevatedButton(
              child: Text('Open'),
              onPressed: pickDirectory,
            ),
          );
        }
        return StreamBuilder(
          stream: _db.watchTracks(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return ListView(
              physics: ClampingScrollPhysics(),
              children: (snapshot.data ?? [])
                  .map((track) => ListTile(
                        title: Text(track.title),
                        subtitle: Text(track.artist),
                        trailing: Text(track.format?.type ?? 'Unknown'),
                      ))
                  .toList(),
            );
          },
        );
      },
    );
  }

  pickDirectory() async {
    if ([TargetPlatform.android, TargetPlatform.iOS, TargetPlatform.windows]
        .contains(defaultTargetPlatform)) {
      final statuses = await [Permission.storage, Permission.audio].request();
      if (kDebugMode) {
        statuses.entries.forEach((e) => print('${e.key}: ${e.value}'));
      }
    }
    final uri = await FilePicker.platform.getDirectoryPath();
    if (uri == null) return;
    await _db.setLocalDataSource(uri);
    setState(() {});
    _fs.findTracks(uri).bufferCount(20).forEach((tracks) async {
      await _db.saveTracks(tracks);
    });
  }
}
