import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../models/track.dart';
import '../pages/pages.dart';

enum AppStatus {
  initial,
  idle,
  playing,
  paused,
}

class PageState extends Equatable {
  final int index;
  final AppStatus status;
  final UnmodifiableListView<Track> queue;

  Track? get currentTrack => queue.isNotEmpty ? queue.first : null;
  AppPage get current => pages[index];
  bool get isPlaying => status == AppStatus.playing;

  const PageState._({
    required this.index,
    required this.status,
    required this.queue,
  });

  PageState.initial()
      : index = 0,
        status = AppStatus.initial,
        queue = UnmodifiableListView([]);

  PageState copyWith({
    int? pageIndex,
    AppStatus? status,
    List<Track>? queue,
  }) {
    return PageState._(
      index: pageIndex ?? this.index,
      status: status ?? this.status,
      queue: queue != null ? UnmodifiableListView(queue) : this.queue,
    );
  }

  @override
  List<Object?> get props => [index, status, queue];
}
