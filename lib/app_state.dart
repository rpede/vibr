import 'package:flutter/material.dart';

import 'pages.dart';
import 'song.dart';

enum PlayerStatus { playing, paused }

class AppState extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex {
    return _selectedIndex;
  }

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  AppPage get currentPage {
    return pages[_selectedIndex];
  }

  var _player = PlayerStatus.playing;

  PlayerStatus get player {
    return _player;
  }

  play() {
    _player = PlayerStatus.playing;
    print(_player);
    notifyListeners();
  }

  pause() {
    _player = PlayerStatus.paused;
    print(_player);
    notifyListeners();
  }

  final currentSong = const Song(
    artist: 'VOLA',
    title: 'Alien Shivers',
    image: 'assets/vola-live-from-the-pool.jpg',
  );
}
