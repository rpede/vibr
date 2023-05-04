import 'dart:io';

import 'package:dart_tags/dart_tags.dart';
import 'package:flac_metadata/flacstream.dart';
import 'package:flac_metadata/metadata.dart';
import 'package:mime/mime.dart';
import 'package:mp3_info/mp3_info.dart';
import 'package:vibr/models/track.dart';

extension StreamExtension<T> on Stream<T> {
  Future<List<T>> asFutureList() async {
    final List<T> values = [];
    await for (final value in this) {
      values.add(value);
    }
    return values;
  }
}

Stream<Track> findTracks(String path) {
  return getFiles(path)
      .asyncMap((file) => extractMetadata(file))
      .where((track) => track != null)
      .map((track) => track as Track);
}

Stream<File> getFiles(String path) {
  return scanDirectory(Directory.fromUri(Uri.parse(path)));
}

Stream<File> scanDirectory(Directory dir) async* {
  await for (final entity in dir.list(recursive: true)) {
    if (entity is Directory) {
      yield* scanDirectory(entity);
    } else if (entity is File) {
      yield entity;
    }
  }
}

Future<Track?> extractMetadata(File file) async {
  final type = lookupMimeType(file.path);
  const supportedTypes = {
    'audio/mpeg': extractMp3Metadata,
    'audio/flac': extractFlacMetadata,
    'audio/x-flac': extractFlacMetadata
  };
  final extractor = supportedTypes[type];
  return extractor != null ? await extractor(file) : null;
}

Future<Track> extractFlacMetadata(File file) async {
  final flac = FlacInfo(file);
  final metadatas = await flac.readMetadatas();
  final streamInfo =
      metadatas.firstWhere((element) => element is StreamInfo) as StreamInfo;
  final comments = metadatas.firstWhere((element) => element is VorbisComment)
      as VorbisComment;
  final m = Map.fromEntries(comments.comments
      .map((e) => e.split("="))
      .map((e) => MapEntry(e[0], e[1])));
  return Track(
      source: file.path,
      artist: m['ARTIST'] ?? 'Unknown',
      album: m['ALBUM'] ?? 'Unkown',
      title: m['TITLE'] ?? 'Unknown',
      genre: m['GENRE'],
      trackNumber: int.tryParse(m['TRACKNUMBER'] ?? ''),
      year: int.tryParse(m['DATE'] ?? ''),
      format: AudioFormat()
        ..sampleRate = streamInfo.sampleRate
        ..bitRate = streamInfo.bitsPerSample
        ..type = 'flac'
        ..channels = streamInfo.channels);
}

Future<Track> extractMp3Metadata(File file) async {
  MP3Info metadata = MP3Processor.fromFile(file);
  final tags = await TagProcessor().getTagsFromByteArray(file.readAsBytes());
  final m = tags.firstWhere((element) => element.tags.isNotEmpty).tags;

  const sampleRates = {
    SampleRate.rate_32000: 32000,
    SampleRate.rate_44100: 44100,
    SampleRate.rate_48000: 48000,
  };

  return Track(
    source: file.path,
    artist: m['artist'] ?? 'Unknown',
    album: m['album'] ?? 'Unknown',
    title: m['title'],
    // duration: m['TLEN']
    genre: m['genre'],
    trackNumber: int.tryParse(m['track'] ?? ''),
    year: int.tryParse(m['year'] ?? ''),
    format: AudioFormat()
      ..sampleRate = sampleRates[metadata.sampleRate]!
      ..type = 'mp3'
      ..bitRate = metadata.bitrate
      ..channels = metadata.channelMode == ChannelMode.single_channel ? 1 : 2,
  );
}
