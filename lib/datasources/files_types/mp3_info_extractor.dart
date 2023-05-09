import 'dart:io';

import 'package:dart_tags/dart_tags.dart';
import 'package:mp3_info/mp3_info.dart';

import '../../models/models.dart';
import 'track_info_extractor.dart';

class Mp3InfoExtractor implements TrackInfoExtractor {
  static const sampleRates = {
    SampleRate.rate_32000: 32000,
    SampleRate.rate_44100: 44100,
    SampleRate.rate_48000: 48000,
  };

  @override
  Future<Track> extract(File file) async {
    MP3Info metadata = MP3Processor.fromFile(file);
    final tags = await TagProcessor().getTagsFromByteArray(file.readAsBytes());
    final m = tags.firstWhere((element) => element.tags.isNotEmpty).tags;

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

  @override
  List<String> get mimeTypes => ['audio/mpeg'];
}
