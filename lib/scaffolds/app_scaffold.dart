import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

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
    var responsive = ResponsiveWrapper.of(context);
    if (responsive.isSmallerThan(TABLET) &&
        responsive.orientation == Orientation.portrait) {
      return MobileScaffold(body: body);
    } else if (responsive.isSmallerThan(DESKTOP)) {
      return TabletScaffold(body: body);
    } else {
      return DesktopScaffold(body: body);
    }
  }
}
