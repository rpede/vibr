import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../file_utils.dart';

class FilesPanel extends StatefulWidget {
  const FilesPanel({super.key});

  @override
  State<FilesPanel> createState() => _FilesPanelState();
}

class _FilesPanelState extends State<FilesPanel> {
  String? path;

  @override
  Widget build(BuildContext context) {
    if (path == null) {
      return Center(
        child: ElevatedButton(
          child: Text('Open'),
          onPressed: pickDirectory,
        ),
      );
    }
    return FutureBuilder(
      future: findTracks(path!),
      initialData: null,
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
  }

  pickDirectory() async {
    if ([TargetPlatform.android, TargetPlatform.iOS, TargetPlatform.windows]
        .contains(defaultTargetPlatform)) {
      final statuses = await [Permission.storage, Permission.audio].request();
      if (kDebugMode) {
        statuses.entries.forEach((e) => print('${e.key}: ${e.value}'));
      }
    }
    path = await FilePicker.platform.getDirectoryPath();
    setState(() {});
  }
}
