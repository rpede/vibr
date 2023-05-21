import 'dart:collection';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../main.dart';
import '../models/models.dart';
import 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  final _player = ap.AudioPlayer();
  final subscriptions = CompositeSubscription();

  PlayerCubit() : super(PlayerState.initial()) {
    subscriptions.add(_player.onPlayerStateChanged.listen((event) {
      final status =
          PlayerStatus.values.firstWhere((status) => status.name == event.name);
      final playing = status == PlayerStatus.playing;
      emit(state.copyWith(status: status, playing: playing));
    }));

    subscriptions.add(_player.onPlayerComplete.listen((event) {
      if (state.hasNext) {
        _player.play(ap.DeviceFileSource(state.nextTrack!.source));
        emit(state.copyWith(index: state.index! + 1));
      }
    }));

    subscriptions.add(CombineLatestStream(
      [_player.onPositionChanged, _player.onDurationChanged],
      (values) => PlaybackPosition(current: values.first, max: values.last),
    ).listen((position) {
      if (position.current <= position.max) {
        emit(state.copyWith(position: position));
      } else {
        emit(state.copyWith(position: null));
      }
    }));
  }

  Future<void> dispose() async {
    subscriptions.cancel();
    await _player.dispose();
  }

  void add(Track track) {
    final queue =
        UnmodifiableListView([...state.queue, QueuedTrack.fromTrack(track)]);
    if ([PlayerStatus.completed, PlayerStatus.stopped].contains(state.status)) {
      _player.play(ap.DeviceFileSource(track.source));
      emit(state.copyWith(queue: queue, index: queue.length - 1));
    } else {
      emit(state.copyWith(queue: queue));
    }
  }

  void addAll(List<Track> tracks) {
    if (tracks.isEmpty) return;
    final queue = UnmodifiableListView(
        [...state.queue, ...tracks.map(QueuedTrack.fromTrack)]);
    if ([PlayerStatus.completed, PlayerStatus.stopped].contains(state.status)) {
      _player.play(ap.DeviceFileSource(queue.first.track.source));
      emit(state.copyWith(queue: queue, index: state.queue.length));
    } else {
      emit(state.copyWith(queue: queue));
    }
  }

  void playPause() {
    state.playing ? _player.pause() : _player.resume();
  }

  void skipNext() {
    if (state.hasNext) {
      _player.play(ap.DeviceFileSource(state.nextTrack!.source));
      emit(state.copyWith(index: state.index! + 1));
    }
  }

  void skipPrevious() {
    if (state.hasPrevious) {
      _player.play(ap.DeviceFileSource(state.previousTrack!.source));
      emit(state.copyWith(index: state.index! - 1));
    }
  }

  void playFromQueue(int index) {
    if (index < state.queue.length) {
      _player.play(ap.DeviceFileSource(state.queue[index].track.source));
      emit(state.copyWith(index: index));
    }
  }

  moveInQueue(int oldIndex, int newIndex) {
    final queuedTrack = state.index != null ? state.queue[state.index!] : null;
    final newQueue = [...state.queue];
    final track = newQueue.removeAt(oldIndex);
    newQueue.insert(oldIndex < newIndex ? newIndex - 1 : newIndex, track);
    emit(state.copyWith(
      queue: UnmodifiableListView(newQueue),
      index: queuedTrack != null ? newQueue.indexOf(queuedTrack) : null,
    ));
  }

  remove(int index) {
    final newQueue = UnmodifiableListView([...state.queue]..removeAt(index));
    int? newIndex;
    if (index == state.index) {
      if (state.hasNext) {
        _player.play(ap.DeviceFileSource(state.nextTrack!.source));
        newIndex = index + 1;
      } else {
        _player.stop();
        newIndex = null;
      }
    } else if (state.index != null && state.index! > index) {
      newIndex = state.index! - 1;
    } else {
      newIndex = index;
    }
    emit(PlayerState(
      playing: state.playing,
      status: state.status,
      queue: newQueue,
      index: newIndex,
    ));
  }
}
