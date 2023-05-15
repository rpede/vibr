import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../models/models.dart';

enum PlayerStatus {
  /// initial state, stop has been called or an error occurred.
  stopped,

  /// Currently playing audio.
  playing,

  /// Pause has been called.
  paused,

  /// The audio successfully completed (reached the end).
  completed,
}

class PlayerState extends Equatable {
  final int? index;

  final bool playing;

  final PlayerStatus status;

  final UnmodifiableListView<QueuedTrack> queue;

  Track? get currentTrack =>
      index != null && queue.isNotEmpty ? queue[index!].track : null;

  bool get hasPrevious => index != null && index! > 0 && queue.isNotEmpty;
  Track? get previousTrack => hasPrevious ? queue[index! - 1].track : null;

  bool get hasNext => index != null && index! + 1 < queue.length;
  Track? get nextTrack => hasNext ? queue[index! + 1].track : null;

  const PlayerState({
    required this.playing,
    required this.status,
    this.index,
    required this.queue,
  });

  PlayerState.initial()
      : playing = false,
        status = PlayerStatus.stopped,
        index = null,
        queue = UnmodifiableListView([]);

  PlayerState copyWith({
    bool? playing,
    PlayerStatus? status,
    int? index,
    UnmodifiableListView<QueuedTrack>? queue,
  }) {
    return PlayerState(
      playing: playing ?? this.playing,
      status: status ?? this.status,
      index: index ?? this.index,
      queue: queue ?? this.queue,
    );
  }

  @override
  List<Object?> get props => [playing, status, index, queue];
}
