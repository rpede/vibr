import 'track.dart';

class Album {
  String name;
  String? image;
  String? artist;

  Album({required this.name, this.image});

  Album.fromTrack(Track track)
      : name = track.album,
        image = track.image,
        artist = track.artist;
}
