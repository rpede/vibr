import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: context.canPop() ? () => context.pop() : null,
      icon: const Icon(Icons.navigate_before),
    );
  }
}
