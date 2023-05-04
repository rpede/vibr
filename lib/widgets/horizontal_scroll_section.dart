import 'package:flutter/material.dart';

import 'section_header.dart';

class HorizontalScrollSection extends StatelessWidget {
  const HorizontalScrollSection(
      {super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemCount: children.length,
              itemBuilder: (context, index) => children[index],
            ),
          ),
        ),
      ],
    );
  }
}
