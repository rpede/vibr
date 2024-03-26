import 'package:flutter/material.dart';

class InlineMessage extends StatelessWidget {
  final String text;

  const InlineMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text('Specal offer on HiFi+, only this week!'),
      ),
    );
  }
}
