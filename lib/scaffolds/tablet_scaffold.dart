import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../widgets/app_navigation_rail.dart';
import '../pages/pages.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({super.key});

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final page = pages[_selectedIndex];
    final badgeColor = Theme.of(context).colorScheme.tertiary;
    final responsive = ResponsiveWrapper.of(context);
    final extended = (responsive.isLargerThan(MOBILE) &&
            // responsive.isMobile &&
            responsive.orientation == Orientation.landscape) ||
        responsive.isLargerThan(TABLET);
    return Scaffold(
        appBar: AppBar(
          title: Text(page.title),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Badge(
                  backgroundColor: badgeColor,
                  child: const Icon(Icons.account_circle_outlined),
                ))
          ],
        ),
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppNavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) => setState(() {
                _selectedIndex = index;
              }),
              extended: extended,
              showPlayer: true,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: page.builder(),
            )),
          ],
        ));
  }
}
