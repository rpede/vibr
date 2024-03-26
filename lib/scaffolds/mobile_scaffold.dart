import 'package:flutter/material.dart';
import 'package:vibr/common/navigator_controls.dart';
import 'package:vibr/common/profile_action.dart';

import '../common/mobile_nav_bar.dart';

class MobileScaffold extends StatelessWidget {
  final Widget body;

  const MobileScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationControls(),
        title: const Text('Vibr'),
        actions: const [ProfileAction()],
      ),
      body: body,
      bottomNavigationBar: const MobileNavBar(),
    );
  }
}
