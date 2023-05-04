import 'package:flutter/material.dart';
import 'package:vibr/widgets/inline_message.dart';

import '../widgets/grid_tile.dart';
import '../widgets/horizontal_scroll_section.dart';

class HomePanel extends StatelessWidget {
  const HomePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      InlineMessage(text: 'Special offer on HiFi+, only this week!'),
      HorizontalScrollSection(
        title: 'Mood Mix',
        children: [
          GridTileItem(title: 'Heavy', image: 'assets/heavy.jpg'),
          GridTileItem(title: 'Relaxing', image: 'assets/relaxing.jpg'),
          GridTileItem(title: 'Moody midnight', image: 'assets/moody.jpg'),
          GridTileItem(title: 'Getting ready', image: 'assets/getting_ready.jpg'),
          GridTileItem(title: 'Sleepy time', image: 'assets/sleepy.jpg',),
        ],
      ),
      HorizontalScrollSection(
        title: 'Recommended',
        children: [
          GridTileItem(title: 'Mix 1', subTitle: 'Metal Classics'),
          GridTileItem(title: 'Mix 2', subTitle: 'Brutal Death'),
          GridTileItem(title: 'Mix 3', subTitle: 'Atmospheric Black'),
          GridTileItem(title: 'Mix 4', subTitle: 'Synthwave'),
          GridTileItem(title: 'Mix 5', subTitle: "Rock'n'Roll"),
        ],
      ),
      HorizontalScrollSection(
        title: 'New Releases',
        children: [
          GridTileItem(title: 'Live From The Pool', subTitle: 'VOLA'),
          GridTileItem(title: 'Senjitsu', subTitle: 'Iron Maiden'),
          GridTileItem(title: 'Suffer in Heaven', subTitle: 'Chelsea Grin'),
          GridTileItem(title: 'Silhouettes of Disgust', subTitle: 'Downfall of Gaia'),
          GridTileItem(title: 'The Awakening', subTitle: 'Kamelot'),
        ],
      ),
    ]);
  }
}
