import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  final String imgaeURL;
  final String title;
  final VoidCallback onTap;

  const ServiceWidget({
    super.key,
    required this.imgaeURL,
    required this.title,
    required this.onTap,
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
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(1000),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                color: Colors.transparent,
              ),
              child: Image.asset(
                imgaeURL,
                width: 48,
                height: 48,
              ),
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
