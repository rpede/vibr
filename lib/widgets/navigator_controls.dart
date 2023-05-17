import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GoRouter.of(context),
      child: Consumer<GoRouter>(
        builder: (context, router, child) => IconButton(
          onPressed: router.canPop() ? () => router.pop() : null,
          icon: const Icon(Icons.navigate_before),
        ),
      ),
    );
  }
}
