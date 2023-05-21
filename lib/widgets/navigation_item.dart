import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.selected,
    required this.icon,
    required this.selectedIcon,
    required this.onPressed,
  });

  final IconData icon;
  final bool selected;
  final IconData selectedIcon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedCrossFade(
        firstChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, size: 32,),
        ),
        secondChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            selectedIcon,
            size: 32,
            color: selectedColor,
            shadows: [Shadow(color: selectedColor, blurRadius: 10)],
          ),
        ),
        crossFadeState:
            selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}
