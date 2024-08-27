import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';

class ServiceWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color backgroundColor;
  final ImageProvider<Object> imgaeURL;
  const ServiceWidget({
    super.key,
    required this.imgaeURL,
    required this.title,
    required this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 68.6,
        padding: const EdgeInsets.only(top: 8),
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundColor,
                  image: DecorationImage(image: imgaeURL, scale: .7)),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                height: 1.2, // Equivalent to line-height: 12px
                color: Color(0xFF5D6166), // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
