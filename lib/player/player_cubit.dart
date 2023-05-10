import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:rxdart/rxdart.dart';

import '../models/track.dart';
import 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  late final just_audio.AudioPlayer _player;
  late final just_audio.ConcatenatingAudioSource _source;
  final subscriptions = CompositeSubscription();

  PlayerCubit() : super(PlayerState.initial()) {
    _player = just_audio.AudioPlayer();
    _source = just_audio.ConcatenatingAudioSource(children: []);
    _player.setAudioSource(_source);
    _player.playbackEventStream;

    subscriptions.add(_player.playerStateStream.listen((event) {
      emit(state.copyWith(
        playing: event.playing,
        processingState: event.processingState,
      ));
    }));

    subscriptions.add(_player.currentIndexStream.listen((index) {
      emit(state.copyWith(index: index));
    }));

    subscriptions.add(_player.playbackEventStream.listen((event) {
      print(event);
    }));
  }

  Future<void> dispose() async {
    subscriptions.cancel();
    await _player.dispose();
  }

  add(Track track) {
    _source.add(just_audio.AudioSource.file(track.source));
    if (!_player.playing) _player.play();
    emit(state.copyWith(queue: UnmodifiableListView([...state.queue, track])));
  }

  playPause() {
    _player.playing ? _player.pause() : _player.play();
  }
}
