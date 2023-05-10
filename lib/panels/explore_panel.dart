import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vibr/widgets/section_header.dart';

class Song {
  final String artist;
  final String title;
  final String? image;

  const Song({required this.artist, required this.title, this.image});
}

class ExplorePanel extends StatelessWidget {
  const ExplorePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SectionHeader(title: 'Suggestions'),
        SongTile(song: Song(artist: 'Arch Enemy', title: 'Reason to Believe', image: 'assets/arch-enemy-will-to-power.jpg')),
        SongTile(song: Song(artist: 'Kalmah', title: 'Heroes To Us', image: 'assets/kalmah-swampsong.jpg')),
        SongTile(song: Song(artist: 'Lorna Shore', title: 'To the Hellfire', image: 'assets/lorna-shore-to-the-hellfire.jpg')),
        SongTile(song: Song(artist: 'Fit For An Autopsy', title: 'Black Mammoth', image: 'assets/fit-for-an-autopsy-the-great-collapse.jpg')),
        SongTile(song: Song(artist: 'Municipal Waste', title: 'The Art of Partying', image: 'assets/municipal-waste-the-art-of-partying.jpg')),
        SectionHeader(title: 'Upcoming'),
        SongTile(song: Song(artist: 'Helge', title: 'Depressive Waters', image: 'assets/helge-depressive-waters.jpg' )),
        SongTile(song: Song(artist: 'Wayward Dawn', title: 'House of Mirrors', image: 'assets/wayward-dawn-house-of-mirrors.jpg')),
        SongTile(song: Song(artist: 'FABRÄK', title: 'VOLDSOMT', image: 'assets/fabrk-rige-brn-leger-bedst.jpg')),
        SongTile(song: Song(artist: 'PåTrods', title: 'Strømsvigt', image: 'assets/ptrods-ptrods.jpg')),
        SongTile(song: Song(artist: 'Seizing Blackwater', title: 'Open Your Eyes', image: 'assets/seizing-blackwater-open-your-eyes.jpg')),
        SectionHeader(title: 'Friends'),
        SongTile(song: Song(artist: 'Ren', title: 'Hi Ren')),
        SongTile(song: Song(artist: 'Corey Taylor', title: 'Snuff')),
        SongTile(song: Song(artist: 'Never Shout Never', title: "Can't Stand It")),
        SongTile(song: Song(artist: 'BABYMETAL', title: 'Gimme Chocolate')),
        SongTile(song: Song(artist: 'Haley Reinhart', title: 'Lovefool')),
      ],
    );
  }
}


class SongTile extends StatelessWidget {
  final Song song;
  const SongTile({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(width: 50, height: 50, child: song.image != null ? Image.asset(song.image!) : Placeholder()),
      title: Text(song.title),
      subtitle: Text(song.artist),
      trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
    );
  }
}
