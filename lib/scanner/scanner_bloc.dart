import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vibr/models/models.dart';

import '../datasources/filesystem_datasource.dart';
import '../datasources/isar_datasource.dart';
import 'scanner_event.dart';
import 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final IsarDataSource _db;
  final FilesystemDataSource _fs;

  ScannerBloc({required IsarDataSource db, required FilesystemDataSource fs})
      : _db = db,
        _fs = fs,
        super(ScannerState.initial()) {
    on<ScannerLoadEvent>(_onLoad);
    on<ScannerPickSourceEvent>(_onPickSource);
    on<ScannerScanEvent>(_onScan);
  }

  Future<void> _onLoad(
      ScannerLoadEvent event, Emitter<ScannerState> emit) async {
    final source = await _db.getLocalDataSource();
    if (source == null) {
      emit(ScannerState.noSource());
    } else {
      final numberOfTracks = await _db.countTracks();
      emit(ScannerState(
        status: ScannerStatus.done,
        numberOfTracks: numberOfTracks,
      ));
    }
  }

  Future<void> _onPickSource(
      ScannerPickSourceEvent event, Emitter<ScannerState> emit) async {
    await _db.setLocalDataSource(event.uri);
    add(ScannerScanEvent());
  }

  Future<void> _onScan(
      ScannerScanEvent event, Emitter<ScannerState> emit) async {
    if (state.status == ScannerStatus.in_progress) return;
    final source = await _db.getLocalDataSource();
    if (source == null) {
      emit(ScannerState.noSource());
    } else {
      emit(state.copyWith(
        status: ScannerStatus.in_progress,
        numberOfTracks: 0,
      ));
      try {
        await _db.clearTracks();
        await _fs
            .findTracks(source.uri)
            .bufferCount(20)
            .asBroadcastStream()
            .forEach((tracks) async {
          await _db.saveTracks(tracks);
        });
        emit(state.copyWith(
          status: ScannerStatus.done,
          numberOfTracks: await _db.countTracks(),
        ));
      } catch (error) {
        emit(state.copyWith(
          status: ScannerStatus.done,
          numberOfTracks: await _db.countTracks(),
          error: error.toString(),
        ));
      }
    }
  }
}
