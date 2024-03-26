import 'package:flutter/material.dart';

import 'section_header.dart';

class Lyrics extends StatelessWidget {
  const Lyrics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionHeader(title: 'Lyrics'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("""
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Vestibulum elementum urna nec sodales porttitor.

Suspendisse interdum urna vel erat lobortis malesuada.
Phasellus faucibus nibh volutpat posuere luctus.

Etiam sed libero at odio egestas faucibus.

Praesent dictum mi a tellus condimentum, nec tincidunt enim dapibus.
Nulla quis dolor eget nulla dignissim aliquam quis at massa.
Maecenas vel eros ac tellus malesuada porttitor sodales at nulla.
Nam vel tellus a nunc gravida blandit eget et velit.
Aenean rhoncus nisl at est pulvinar, vitae ultrices purus congue.

Sed sit amet diam in sapien hendrerit laoreet.
Phasellus vestibulum dolor vel neque venenatis cursus ac a nisi.
Mauris a nisl et diam vulputate pharetra.
Vivamus fermentum tortor posuere iaculis eleifend.
Sed eleifend est quis arcu semper, in blandit sapien porta.
        """),
        )
      ],
    );
  }
}
