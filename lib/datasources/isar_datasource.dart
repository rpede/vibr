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

  Future<List<Track>> getTracksByAlbum({
    String? artist,
    required String album,
  }) async {
    var query = _isar.tracks.filter().albumEqualTo(album);
    if (artist != null) query = query.artistEqualTo(artist);
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

  Future<List<String>> getGenres() async {
    final genres = await _isar.tracks
        .where()
        .distinctByGenre(caseSensitive: false)
        .genreProperty()
        .findAll();
    return genres.where((e) => e != null).map((e) => e as String).toList();
  }

  Future<List<Search>> getLastSearches(int number) async {
    return await _isar.searchs
        .where()
        .sortByTimestampDesc()
        .limit(number)
        .findAll();
  }

  Future<List<Track>> searchForTracks(String term, {Set<String>? genres}) {
    final query = term.split(' ').fold(
        _isar.tracks.filter(),
        (previousValue, element) =>
            previousValue.textElementStartsWith(element).or());
    return query.idGreaterThan(-1).findAll();
  }

  Future<int> saveSearch(Search search) async {
    return await _isar.writeTxn(() => _isar.searchs.put(search));
  }
}
