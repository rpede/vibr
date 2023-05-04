import 'package:isar/isar.dart';

part 'track.g.dart';

@collection
class Track {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  int? trackNumber;
  String artist;
  String album;
  String title;
  String? genre;
  int? year;
  int? durationInSeconds;
  AudioFormat? format;
  String source;

  Track({
    this.trackNumber,
    required this.artist,
    required this.album,
    required this.title,
    this.genre,
    this.year,
    this.durationInSeconds,
    this.format,
    required this.source,
  });
}

@embedded
class AudioFormat {
  int? bitRate;
  int? sampleRate;
  String? type;
  int? channels;

  // AudioFormat({
  //   this.bitRate,
  //   required this.sampleRate,
  //   required this.type,
  //   this.channels,
  // });
}
