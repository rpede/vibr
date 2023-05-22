import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibr/player/player_cubit.dart';

import '../widgets/glow.dart';

class PlaybackSlider extends StatefulWidget {
  const PlaybackSlider({
    super.key,
  });

  @override
  State<PlaybackSlider> createState() => _PlaybackSliderState();
}

class _PlaybackSliderState extends State<PlaybackSlider> {
  Duration? _seek = null;

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.tertiary;
    final position =
        context.select((PlayerCubit player) => player.state.position);
    final current = _seek ?? position?.current ?? const Duration();
    final max = position?.max ?? const Duration();
    return Glow(
      child: Slider(
        thumbColor: accentColor,
        value: current.inSeconds.toDouble(),
        max: max.inSeconds.toDouble(),
        label: '${current.format()} / ${max.format()}',
        onChangeEnd: (value) {
          context.read<PlayerCubit>().seek(Duration(seconds: value.toInt()));
        },
        onChanged: (double value) {
          setState(() {
            _seek = Duration(seconds: value.toInt());
          });
        },
      ),
    );
  }
}

extension DurationExtension on Duration {
  format() => '$inMinutes:${inSeconds % 59}';
}
