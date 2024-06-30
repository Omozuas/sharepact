import 'package:flutter/material.dart';
import 'responsive_widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ResponsiveImage(
          imagePath: 'assets/sharepact_logo.png',
          heightFactor: 0.3, // 30% of screen height
          widthFactor: 0.6,  // 60% of screen width
        ),
      ),
    );
  }
}
