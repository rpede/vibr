import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:vibr/common/navigator_controls.dart';

import '../common/app_navigation_rail.dart';
import '../common/profile_action.dart';

class TabletScaffold extends StatelessWidget {
  final Widget body;

  const TabletScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final extended = (responsive.isMobile &&
            responsive.orientation == Orientation.landscape) ||
        responsive.isDesktop;
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationControls(),
        title: const Text('Vibr'),
        actions: const [ProfileAction()],
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          AppNavigationRail(extended: extended, showPlayer: true),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
