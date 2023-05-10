import 'package:isar/isar.dart';

import '../models/models.dart';

class IsarDataSource {
  final Isar _isar;

  IsarDataSource(this._isar);

  Future<Source?> getLocalDataSource() {
    return _isar.sources.filter().localEqualTo(true).findFirst();
  }

  Future<Source> setLocalDataSource(String uri) async {
    var source = await getLocalDataSource();
    source ??= Source(local: true, uri: uri);
    await _isar.writeTxn(() async {
      return await _isar.sources.put(source!);
    });
    return source;
  }

  Future<bool> removeSource(int id) async {
    return await _isar.writeTxn(() async {
      return await _isar.sources.delete(id);
    });
  }

  Future<void> clearTracks() async {
    return await _isar.writeTxn(() async {
      return await _isar.tracks.clear();
    });
  }

  Future<List<int>> saveTracks(List<Track> tracks) async {
    return await _isar.writeTxn(() async => _isar.tracks.putAll(tracks));
  }

  Future<int> countTracks() {
    return _isar.tracks.count();
  }

  Stream<List<Track>> watchTracks() {
    return _isar.tracks
        .filter()
        .trackNumberGreaterThan(0)
        .sortByArtist()
        .thenByTitle()
        .build()
        .watch();
  }
}
