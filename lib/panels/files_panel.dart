import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:vibr/models/source.dart';
import 'package:rxdart/rxdart.dart';

import '../file_utils.dart';
import '../models/track.dart';

class FilesPanel extends StatefulWidget {
  const FilesPanel({super.key});

  @override
  State<FilesPanel> createState() => _FilesPanelState();
}

class _FilesPanelState extends State<FilesPanel> {
  late Isar _isar;

  @override
  void initState() {
    _isar = context.read<Isar>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSource(),
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
          stream: getTracks(),
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

  Future<Source?> getSource() {
    return _isar.sources.filter().localEqualTo(true).findFirst();
  }

  Stream<List<Track>> getTracks() {
    return _isar.tracks
        .filter()
        .trackNumberGreaterThan(0)
        .sortByArtist()
        .thenByTitle()
        .build()
        .watch();
  }

  Future<bool> removeSource(int id) async {
    final result = await _isar.writeTxn(() async {
      return await _isar.sources.delete(id);
    });
    setState(() {});
    return result;
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
    await _isar.writeTxn(() async {
      await _isar.sources.put(Source(local: true, uri: uri));
    });
    setState(() {});
    findTracks(uri).bufferCount(20).forEach((tracks) async {
      await _isar.writeTxn(() async => _isar.tracks.putAll(tracks));
    });
  }
}
