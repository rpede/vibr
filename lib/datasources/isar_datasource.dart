import 'package:isar/isar.dart';

import '../models/album.dart';
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

  Future<List<int>> saveTracks(List<Track> tracks) async {
    return await _isar.writeTxn(() async => _isar.tracks.putAll(tracks));
  }

  Future<void> clearTracks() async {
    return await _isar.writeTxn(() async {
      return await _isar.tracks.clear();
    });
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
        .watch(fireImmediately: true);
  }

  Future<List<String>> getArtists() async {
    final tracks = await _isar.tracks.where().distinctByArtist().findAll();
    return tracks.map((e) => e.artist).toList();
  }

  Future<List<Album>> getAlbums() async {
    final tracks = await _isar.tracks
        .where()
        .sortByAlbum()
        .distinctByArtist()
        .distinctByAlbum()
        .findAll();
    return tracks.map((e) => Album.fromTrack(e)).toList();
  }

  Future<List<Album>> getAlbumsByArtist(String artist) async {
    final tracks = await _isar.tracks
        .where()
        .artistEqualTo(artist)
        .sortByAlbum()
        .distinctByArtist()
        .distinctByAlbum()
        .findAll();
    return tracks.map((e) => Album.fromTrack(e)).toList();
  }

  Future<List<Track>> getTracks() async {
    return await _isar.tracks.where().findAll();
  }

  Future<List<Track>> getTracksByAlbum(Album album) async {
    var query = _isar.tracks.filter().albumEqualTo(album.name);
    if (album.artist != null) query = query.artistEqualTo(album.artist!);
    return await query.sortByTitle().findAll();
  }

  Future<List<Track>> getTracksByArtist(String artist) async {
    final tracks = await _isar.tracks
        .filter()
        .artistEqualTo(artist)
        .sortByTitle()
        .findAll();
    return tracks;
  }
}
