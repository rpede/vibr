import 'package:flutter/material.dart';
import '../theme.dart';

class ProfileAction extends StatelessWidget {
  const ProfileAction({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Badge(
        backgroundColor: context.color().tertiary,
        child: const Icon(Icons.account_circle_outlined),
      ),
    );
  }
}
