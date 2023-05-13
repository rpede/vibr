import 'track.dart';

class Album {
  String name;
  String? image;

  Album({required this.name, this.image});

  Album.fromTrack(Track track)
      : name = track.album,
        image = track.image;
}
