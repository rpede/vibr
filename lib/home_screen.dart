import 'package:flutter/material.dart';
import 'package:vibr/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.network(
              'https://wallpapercave.com/wp/wp5882343.jpg',
              fit: BoxFit.fitHeight,
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
