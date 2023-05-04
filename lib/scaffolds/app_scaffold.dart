import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'desktop_scaffold.dart';
import 'mobile_scaffold.dart';
import 'tablet_scaffold.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var responsive = ResponsiveWrapper.of(context);
    if (responsive.isSmallerThan(TABLET) &&
        responsive.orientation == Orientation.portrait) {
      return const MobileScaffold();
    } else if (responsive.isSmallerThan(DESKTOP)) {
      return const TabletScaffold();
    } else {
      return const DesktopScaffold();
    }
  }
}
