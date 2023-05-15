import 'package:flutter/material.dart';
import 'package:vibr/widgets/profile_action.dart';

import '../widgets/mobile_nav_bar.dart';

class MobileScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const MobileScaffold({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: const [ProfileAction()]
      ),
      body: body,
      bottomNavigationBar: const MobileNavBar(),
    );
  }
}
