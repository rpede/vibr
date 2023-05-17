import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../datasources/filesystem_datasource.dart';
import '../datasources/isar_datasource.dart';
import '../scaffolds/app_scaffold.dart';
import 'scanner_bloc.dart';
import 'scanner_event.dart';
import 'scanner_state.dart';

class ScannerPanel extends StatelessWidget {
  static const title = 'Scanner';

  const ScannerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<IsarDataSource>();
    final fs = context.read<FilesystemDataSource>();
    return ResponsiveScaffold(
      title: title,
      body: BlocProvider(
        create: (_) => ScannerBloc(db: db, fs: fs)..add(ScannerLoadEvent()),
        child: BlocBuilder<ScannerBloc, ScannerState>(
          builder: (context, state) {
            if (state.error != null) _showError(context, state.error!);
            switch (state.status) {
              case ScannerStatus.initial:
                return _buildInitial();
              case ScannerStatus.no_source:
                return _buildNoSource(context);
              case ScannerStatus.in_progress:
                return _buildInProgress(state);
              case ScannerStatus.done:
                return _buildDone(context, state);
            }
          },
        ),
      ),
    );
  }

  Widget _buildInitial() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildNoSource(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () async {
          final uri = await _pickDirectory();
          if (uri == null) return;
          context.read<ScannerBloc>().add(ScannerPickSourceEvent(uri));
        },
        icon: Icon(Icons.folder),
        label: Text('Pick'),
      ),
    );
  }

  Widget _buildInProgress(ScannerState state) {
    return Center(
      child: Column(
        children: [
          Text('Scanning for music files...'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildDone(BuildContext context, ScannerState state) {
    return Center(
      child: Column(children: [
        Text(
          'Complete',
          style: TextStyle(fontSize: 30),
        ),
        Text('Found ${state.numberOfTracks} tracks'),
        ElevatedButton(
          onPressed: () {
            context.read<ScannerBloc>().add(ScannerScanEvent());
          },
          child: Text('Rescan'),
        ),
        TextButton(
          onPressed: () async {
            final uri = await _pickDirectory();
            if (uri == null) return;
            context.read<ScannerBloc>().add(ScannerPickSourceEvent(uri));
          },
          child: Text('Change source'),
        )
      ]),
    );
  }

  Future<String?> _pickDirectory() async {
    if ([TargetPlatform.android, TargetPlatform.iOS, TargetPlatform.windows]
        .contains(defaultTargetPlatform)) {
      final statuses = await [Permission.storage, Permission.audio].request();
      if (kDebugMode) {
        statuses.entries.forEach((e) => print('${e.key}: ${e.value}'));
      }
    }
    return await FilePicker.platform.getDirectoryPath();
  }

  void _showError(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(error),
      ),
    );
  }
}
