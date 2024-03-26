import 'package:flutter/material.dart';
import '../theme.dart';

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
              // 'assets/A vibrant.jpg',
              'assets/Hooded man playing electric guitar on stage.jpg',
              // 'https://wallpapercave.com/wp/wp5882343.jpg',
              // fit: BoxFit.fitHeight,
              fit: BoxFit.cover
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
