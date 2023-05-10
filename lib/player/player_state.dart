import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

import '../models/track.dart';

class PlayerState extends Equatable {
  final int? index;

  /// Whether the player will play when [processingState] is
  /// [ProcessingState.ready].
  final bool playing;

  /// The current processing state of the player.
  final ProcessingState processingState;

  final UnmodifiableListView<Track> queue;

  Track? get currentTrack =>
      index != null && queue.isNotEmpty ? queue[index!] : null;

  const PlayerState({
    required this.playing,
    required this.processingState,
    this.index,
    required this.queue,
  });

  PlayerState.initial()
      : playing = false,
        processingState = ProcessingState.idle,
        index = null,
        queue = UnmodifiableListView([]);

  PlayerState copyWith({
    bool? playing,
    ProcessingState? processingState,
    int? index,
    UnmodifiableListView<Track>? queue,
  }) {
    return PlayerState(
      playing: playing ?? this.playing,
      processingState: processingState ?? this.processingState,
      index: index ?? this.index,
      queue: queue ?? this.queue,
    );
  }

  @override
  List<Object?> get props => [playing, processingState, index, queue];
}
