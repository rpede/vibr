import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../datasources/filesystem_datasource.dart';
import '../datasources/isar_datasource.dart';
import '../pages.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final IsarDataSource _db;
  final FilesystemDataSource _fs;

  AppCubit({required IsarDataSource db, required FilesystemDataSource fs})
      : _db = db,
        _fs = fs,
        super(AppState.initial());

  void setPageIndex(int index) {
    if (index <= pages.length) emit(state.copyWith(pageIndex: index));
  }

  void playPause() {
    state.status == AppStatus.playing ? pause() : play();
  }

  void play() {
    emit(state.copyWith(status: AppStatus.playing));
  }

  void pause() {
    emit(state.copyWith(status: AppStatus.paused));
  }
}
