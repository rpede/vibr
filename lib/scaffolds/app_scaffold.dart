import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'desktop_scaffold.dart';
import 'mobile_scaffold.dart';
import 'tablet_scaffold.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget body;

  const ResponsiveScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    var responsive = ResponsiveBreakpoints.of(context);
    if (responsive.isMobile &&
        responsive.orientation == Orientation.portrait) {
      return MobileScaffold(body: body);
    } else if (responsive.isTablet) {
      return TabletScaffold(body: body);
    } else {
      return DesktopScaffold(body: body);
    }
  }
}
