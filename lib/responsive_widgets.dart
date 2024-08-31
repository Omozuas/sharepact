import 'package:flutter/material.dart';

class ResponsiveImageNetwork extends StatelessWidget {
  final String imagePath;
  final double heightFactor;
  final double widthFactor;

  const ResponsiveImageNetwork({
    super.key,
    required this.imagePath,
    this.heightFactor = 0.3,
    this.widthFactor = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Image.network(
      imagePath,
      height: screenSize.height * heightFactor,
      width: screenSize.width * widthFactor,
      fit: BoxFit.contain,
    );
  }
}

class ResponsiveImage extends StatelessWidget {
  final String imagePath;
  final double heightFactor;
  final double widthFactor;

  const ResponsiveImage({
    super.key,
    required this.imagePath,
    this.heightFactor = 0.3,
    this.widthFactor = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Image.asset(
      imagePath,
      height: screenSize.height * heightFactor,
      width: screenSize.width * widthFactor,
      fit: BoxFit.contain,
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double paddingFactor;

  const ResponsiveContainer(
      {super.key, required this.child, this.paddingFactor = 0.05});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(screenSize.width * paddingFactor),
      child: child,
    );
  }
}
