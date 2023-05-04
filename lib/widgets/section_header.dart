import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: EdgeInsets.only(top: 36, bottom: 16, left: 8, right: 8),
      child: Text(
        title,
        style: textTheme.headlineMedium,
      ),
    );
  }
}
