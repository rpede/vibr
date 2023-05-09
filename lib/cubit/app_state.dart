import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../models/track.dart';
import '../pages.dart';

enum AppStatus {
  initial,
  idle,
  playing,
  paused,
}

class AppState extends Equatable {
  final int pageIndex;
  final AppStatus status;
  final UnmodifiableListView<Track> queue;

  Track? get currentTrack => queue.isNotEmpty ? queue.first : null;
  AppPage get currentPage => pages[pageIndex];
  bool get isPlaying => status == AppStatus.playing;

  const AppState._({
    required this.pageIndex,
    required this.status,
    required this.queue,
  });

  AppState.initial()
      : pageIndex = 0,
        status = AppStatus.initial,
        queue = UnmodifiableListView([]);

  AppState copyWith({
    int? pageIndex,
    AppStatus? status,
    List<Track>? queue,
  }) {
    return AppState._(
      pageIndex: pageIndex ?? this.pageIndex,
      status: status ?? this.status,
      queue: queue != null ? UnmodifiableListView(queue) : this.queue,
    );
  }

  @override
  List<Object?> get props => [pageIndex, status, queue];
}
