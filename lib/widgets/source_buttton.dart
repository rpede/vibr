import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:permission_handler/permission_handler.dart';

class SourceButton extends StatelessWidget {
  const SourceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
    // await _db.setLocalDataSource(uri);
    // setState(() {});
    // _fs.findTracks(uri).bufferCount(20).forEach((tracks) async {
    //   await _db.saveTracks(tracks);
    // });
  }
}
