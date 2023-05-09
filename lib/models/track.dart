import 'package:isar/isar.dart';

part 'track.g.dart';

@collection
class Track {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  int? trackNumber;

  @Index()
  String artist;

  String album;
  @Index()
  String title;
  String? genre;
  int? year;
  int? durationInSeconds;
  AudioFormat? format;
  String source;

  String? image;

  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get text => [artist, title, album];

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
    this.image,
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
