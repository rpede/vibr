import 'package:flutter/material.dart';

class LibraryPanel extends StatelessWidget {
  const LibraryPanel({super.key});

  final items = const [
    'Artists',
    'Songs',
    'Albums',
    'Playlists',
  ];

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineLarge;
    return ListView(
      physics: ClampingScrollPhysics(),
      children: [
        SizedBox(height: 32),
        for (final item in items)
          ListTile(title: Text(item, style: textStyle), onTap: () {}),
      ],
    );
  }
}
