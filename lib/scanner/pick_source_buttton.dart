import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:vibr/scanner/scanner_bloc.dart';
import 'package:vibr/scanner/scanner_event.dart';

class PickSourceButton extends StatelessWidget {
  const PickSourceButton({super.key});

  @override
  Widget build(BuildContext context) {
    final scanner = context.read<ScannerBloc>();
    return ElevatedButton.icon(
      onPressed: () async {
        final uri = await pickDirectory();
        if (uri == null) return;
        scanner.add(ScannerPickSourceEvent(uri));
      },
      icon: Icon(Icons.folder),
      label: Text('Pick'),
    );
  }

  Future<String?> pickDirectory() async {
    if ([TargetPlatform.android, TargetPlatform.iOS, TargetPlatform.windows]
        .contains(defaultTargetPlatform)) {
      final statuses = await [Permission.storage, Permission.audio].request();
      if (kDebugMode) {
        statuses.entries.forEach((e) => print('${e.key}: ${e.value}'));
      }
    }
    return await FilePicker.platform.getDirectoryPath();
  }
}
