import 'dart:collection';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vibr/main.dart';
import 'package:vibr/models/album.dart';

import '../models/track.dart';
import 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  // late final just_audio.AudioPlayer _player;
  // late final just_audio.ConcatenatingAudioSource _source;
  final _player = ap.AudioPlayer();
  final subscriptions = CompositeSubscription();

  PlayerCubit() : super(PlayerState.initial()) {
    // _checkLinuxSupport();

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
  }

  void _checkLinuxSupport() {
    if (Platform.isLinux) {
      Process.run("which", ["mpv"]).then((result) {
        if (result.exitCode != 0) {
          scaffoldMessengerKey.currentState?.showSnackBar(const SnackBar(
              content: Text(
                  '''Command "mpv" was not found.\nIt is required on Linux.''')));
        }
      });
    }
  }

  Future<void> dispose() async {
    subscriptions.cancel();
    await _player.dispose();
  }

  void add(Track track) {
    final queue = UnmodifiableListView([...state.queue, track]);
    if ([PlayerStatus.completed, PlayerStatus.stopped].contains(state.status)) {
      _player.play(ap.DeviceFileSource(track.source));
      emit(state.copyWith(queue: queue, index: queue.length - 1));
    } else {
      emit(state.copyWith(queue: queue));
    }
  }

  void addAll(List<Track> tracks) {
    if (tracks.isNotEmpty) return;
    final queue = UnmodifiableListView([...state.queue, ...tracks]);
    if ([PlayerStatus.completed, PlayerStatus.stopped].contains(state.status)) {
      _player.play(ap.DeviceFileSource(queue.first.source));
      emit(state.copyWith(queue: queue, index: queue.length - 1));
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
      _player.play(ap.DeviceFileSource(state.queue[index].source));
      emit(state.copyWith(index: index));
    }
  }
}
