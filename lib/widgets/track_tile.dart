import 'package:flutter/material.dart';

import '../models/models.dart';

class TrackTile extends StatelessWidget {
  final Track track;
  const TrackTile({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(width: 50, height: 50, child: track.image != null ? Image.asset(track.image!) : Placeholder()),
      title: Text(track.title),
      subtitle: Text(track.artist),
      trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
    );
  }
}
