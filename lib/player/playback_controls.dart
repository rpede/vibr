import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibr/theme.dart';

import '../player/player_cubit.dart';
import '../widgets/glow.dart';

class PlaybackControls extends StatefulWidget {
  final double size;
  final bool showSkip;

  const PlaybackControls({super.key, required this.size, this.showSkip = true});

  @override
  State<PlaybackControls> createState() => _PlaybackControlsState();
}

class _PlaybackControlsState extends State<PlaybackControls>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));
  late final _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  late final StreamSubscription _subscription;

  @override
  void initState() {
    final player = context.read<PlayerCubit>();
    _controller.value = player.state.playing ? 0 : 1;
    _subscription = player.stream.listen((event) {
      if (event.playing) {
        _controller.reverse(from: _controller.value);
      } else {
        _controller.forward(from: _controller.value);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Glow(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.showSkip) _buildSkipPrev(context),
          _buildPlayPause(context),
          if (widget.showSkip) _buildSkipNext(context),
        ],
      ),
    );
  }

  _buildPlayPause(BuildContext context) {
    return IconButton(
      key: ValueKey('play-pause'),
      onPressed: () {
        context.read<PlayerCubit>().playPause();
      },
      icon: AnimatedIcon(
        size: widget.size,
        color: context.color().tertiary,
        // shadows: [BoxShadow(color: colorScheme.tertiary, blurRadius: 10)],
        icon: AnimatedIcons.pause_play,
        progress: _animation,
      ),
    );
  }

  _buildSkipNext(BuildContext context) {
    final hasNext = context.select((PlayerCubit cubit) => cubit.state.hasNext);
    if (hasNext) {
      return IconButton(
        onPressed: () => context.read<PlayerCubit>().skipNext(),
        icon: Icon(
          Icons.skip_next_outlined,
          size: widget.size,
          color: context.color().tertiary,
        ),
      );
    } else {
      return IconButton(
        onPressed: null,
        icon: Icon(
          Icons.skip_next_outlined,
          size: widget.size,
          color: context.color().tertiaryContainer,
        ),
      );
    }
  }

  _buildSkipPrev(BuildContext context) {
    final hasPrevious =
        context.select((PlayerCubit cubit) => cubit.state.hasPrevious);
    if (hasPrevious) {
      return IconButton(
        onPressed: () => context.read<PlayerCubit>().skipPrevious(),
        icon: Icon(
          Icons.skip_previous_outlined,
          size: widget.size,
          color: context.color().tertiary,
        ),
      );
    } else {
      return IconButton(
        onPressed: null,
        icon: Icon(
          Icons.skip_previous_outlined,
          size: widget.size,
          color: context.color().tertiaryContainer,
        ),
      );
    }
  }
}
