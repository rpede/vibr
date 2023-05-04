import 'dart:ui';

import 'package:flutter/material.dart';

class Glow extends StatelessWidget {
  final Widget child;
  final Color blurColor;
  final double blur;

  const Glow({
    super.key,
    required this.child,
    this.blur = 5,
    this.blurColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final double blur = 5;
    final blurColor = Colors.white;
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(child: child),
            ),
          ),
        ],
      ),
    );
  }
}
