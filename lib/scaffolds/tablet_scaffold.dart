import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:vibr/widgets/navigator_controls.dart';

import '../widgets/app_navigation_rail.dart';
import '../widgets/profile_action.dart';

class TabletScaffold extends StatelessWidget {
  final Widget body;

  const TabletScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveWrapper.of(context);
    final extended = (responsive.isLargerThan(MOBILE) &&
            // responsive.isMobile &&
            responsive.orientation == Orientation.landscape) ||
        responsive.isLargerThan(TABLET);
    return Scaffold(
      appBar: AppBar(
        leading: NavigationControls(),
        title: Text('Vibr'),
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
