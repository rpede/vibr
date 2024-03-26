import 'package:flutter/material.dart';
import 'package:vibr/widgets/section_header.dart';

final genres = [
  'Heavy Metal',
  'Rock',
  'Reggae',
  'Hip-Hop',
  'Indie',
  'Jazz',
  'EDM'
];

class SearchPanel extends StatelessWidget {
  const SearchPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              suffixIcon: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.search),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: "Genres"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: genres
                        .map((genre) => Chip(
                            backgroundColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            label: Text(genre)))
                        .toList(),
                  ),
                ),
                const SectionHeader(title: 'Previous'),
                const ListTile(
                    title: Text('Doom OST'), trailing: Icon(Icons.close)),
                const ListTile(
                    title: Text('Infected Rain'),
                    trailing: Icon(Icons.close)),
                const ListTile(
                    title: Text('Lorna Shore'), trailing: Icon(Icons.close)),
                const ListTile(
                    title: Text('Imminence'), trailing: Icon(Icons.close)),
                const ListTile(
                    title: Text('Arch Enemy'), trailing: Icon(Icons.close)),
                const ListTile(title: Text('Kreator'), trailing: Icon(Icons.close)),
                const ListTile(
                    title: Text('Fit for an Autopsy'),
                    trailing: Icon(Icons.close)),
                const ListTile(
                    title: Text('The Algorithm'),
                    trailing: Icon(Icons.close)),
                const ListTile(
                    title: Text('Master Boot Record'),
                    trailing: Icon(Icons.close))
              ]),
        ),
      ],
    );
  }
}
