import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './player_cubit.dart';
import '../widgets/glow.dart';

class PlaybackSlider extends StatelessWidget {
  const PlaybackSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.tertiary;
    final position =
        context.select((PlayerCubit player) => player.state.position);
    final current = position?.current ?? const Duration();
    final max = position?.max ?? const Duration();
    return Glow(
      child: Slider(
        thumbColor: accentColor,
        value: current.inSeconds.toDouble(),
        max: max.inSeconds.toDouble(),
        label:
            '${current.inMinutes}:${current.inSeconds % 59} / ${max.inMinutes}:${max.inSeconds % 59}',
        onChanged: (double value) {},
      ),
    );
  }
}
