import 'package:flutter/material.dart';

const scrollPhysics = ClampingScrollPhysics();

class StretchingScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return StretchingOverscrollIndicator(
      axisDirection: details.direction,
      child: child,
    );
  }

  // Set physics to clamping.
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return scrollPhysics;
  }
}

class StretchingScrollWrapper extends StatelessWidget {
  final Widget child;

  const StretchingScrollWrapper({super.key, required this.child});

  static Widget builder(BuildContext context, Widget child) {
    return StretchingScrollWrapper(child: child);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: StretchingScrollBehavior(),
      child: child,
    );
  }
}
