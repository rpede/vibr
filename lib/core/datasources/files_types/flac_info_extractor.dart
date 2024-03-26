import 'dart:io';

import 'package:flac_metadata/flacstream.dart';
import 'package:flac_metadata/metadata.dart';

import '../../models/models.dart';
import 'track_info_extractor.dart';

class FlacInfoExtractor implements TrackInfoExtractor {
  const FlacInfoExtractor();

  @override
  Future<Track> extract(File file) async {
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

  @override
  List<String> get mimeTypes => ['audio/flac', 'audio/x-flac'];
}
