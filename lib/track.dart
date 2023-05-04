class Track {
  final int? trackNumber;
  final String artist;
  final String album;
  final String title;
  final String? genre;
  final int? year;
  final Duration? duration;
  final AudioFormat? format;
  final String source;

  const Track({
    this.trackNumber,
    required this.artist,
    required this.album,
    required this.title,
    this.genre,
    this.year,
    this.duration,
    this.format,
    required this.source,
  });
}

class AudioFormat {
  final int? bitRate;
  final Duration? duration;
  final int sampleRate;
  final String type;
  final int? channels;

  const AudioFormat(
      {this.bitRate,
      this.duration,
      required this.sampleRate,
      required this.type,
      this.channels});
}
