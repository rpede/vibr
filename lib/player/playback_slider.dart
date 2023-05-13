import 'package:flutter/material.dart';

import '../widgets/glow.dart';

class PlaybackSlider extends StatelessWidget {
  const PlaybackSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.tertiary;
    return Glow(
      child: Slider(
        thumbColor: accentColor,
        value: 20,
        max: 100,
        divisions: 5,
        label: '0:52 / 4:18',
        onChanged: (double value) {},
      ),
    );
  }
}
