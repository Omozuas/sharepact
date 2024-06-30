import 'package:flutter/material.dart';

class ResponsiveOnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const ResponsiveOnboardingPage({
    super.key, 
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        // Container for the onboarding image
        Container(
          height: screenSize.height * 0.5, // Adjust the height as needed
          width: double.infinity,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: screenSize.height * 0.05),
        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: screenSize.width * 0.06,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: screenSize.height * 0.02),
        // Description
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
          child: Text(
            description,
            style: TextStyle(fontSize: screenSize.width * 0.04),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
