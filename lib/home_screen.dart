import 'package:flutter/material.dart';
import 'theme/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/splash_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text('Vibr', style: context.text().headlineLarge),
          ),
        ],
      ),
    );
  }
}
