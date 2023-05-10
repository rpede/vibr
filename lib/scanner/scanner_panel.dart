import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../datasources/filesystem_datasource.dart';
import '../datasources/isar_datasource.dart';
import 'pick_source_buttton.dart';
import 'scanner_bloc.dart';
import 'scanner_event.dart';
import 'scanner_state.dart';

class ScannerPanel extends StatelessWidget {
  const ScannerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<IsarDataSource>();
    final fs = context.read<FilesystemDataSource>();
    return BlocProvider(
      create: (_) => ScannerBloc(db: db, fs: fs)..add(ScannerLoadEvent()),
      child: BlocBuilder<ScannerBloc, ScannerState>(
        builder: (context, state) {
          if (state.error != null) _showError(context, state.error!);
          switch (state.status) {
            case ScannerStatus.initial:
              return _buildInitial();
            case ScannerStatus.no_source:
              return _buildNoSource();
            case ScannerStatus.in_progress:
              return _buildInProgress(state);
            case ScannerStatus.done:
              return _buildDone(context, state);
          }
        },
      ),
    );
  }

  Widget _buildInitial() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildNoSource() {
    return Center(child: PickSourceButton());
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
        TextButton(
          onPressed: () {
            context.read<ScannerBloc>().add(ScannerScanEvent());
          },
          child: Text('Rescan'),
        )
      ]),
    );
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
