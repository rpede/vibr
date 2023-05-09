import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cubit/app_cubit.dart';
import '../cubit/app_state.dart';
import 'glow.dart';

class PlaybackControls extends StatefulWidget {
  final double size;
  final bool showSkip;

  const PlaybackControls({super.key, required this.size, this.showSkip = true});

  @override
  State<PlaybackControls> createState() => _PlaybackControlsState();
}

class _PlaybackControlsState extends State<PlaybackControls>
    with SingleTickerProviderStateMixin {
  late final _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  late final _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

  @override
  void initState() {
    final status = context.read<AppCubit>().state.status;
    _controller.value = status == AppStatus.playing ? 1 : 0;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Glow(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.showSkip) _buildSkip(context, Icons.skip_previous_outlined),
          _buildPlayPause(context),
          if (widget.showSkip) _buildSkip(context, Icons.skip_next_outlined),
        ],
      ),
    );
  }

  _buildPlayPause(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // final state = Provider.of<AppState>(context);
    return IconButton(
      key: ValueKey('play-pause'),
      onPressed: () {
        final cubit = context.read<AppCubit>();
        if (cubit.state.status == AppStatus.paused) {
          cubit.play();
          _controller.forward(from: _controller.value);
        } else if (cubit.state.status == AppStatus.playing) {
          cubit.pause();
          _controller.reverse(from: _controller.value);
        }
      },
      icon: AnimatedIcon(
        size: widget.size,
        color: colorScheme.tertiary,
        // shadows: [BoxShadow(color: colorScheme.tertiary, blurRadius: 10)],
        icon: AnimatedIcons.pause_play,
        progress: _animation,
      ),
    );
  }

  _buildSkip(BuildContext context, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {},
      icon: Icon(
        icon,
        size: widget.size,
        color: colorScheme.tertiary,
        // shadows: [BoxShadow(color: colorScheme.tertiary, blurRadius: 10)],
      ),
    );
  }
}
