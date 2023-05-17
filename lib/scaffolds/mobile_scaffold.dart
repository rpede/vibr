import 'package:flutter/material.dart';
import 'package:vibr/widgets/navigator_controls.dart';
import 'package:vibr/widgets/profile_action.dart';

import '../widgets/mobile_nav_bar.dart';

class MobileScaffold extends StatelessWidget {
  final Widget body;

  const MobileScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: NavigationControls(),
        title: Text('Vibr'),
        actions: const [ProfileAction()],
      ),
      body: body,
      bottomNavigationBar: const MobileNavBar(),
    );
  }
}
