import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22), // Match search bar padding
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Hi Jane Doe',
              style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                Image.asset(
                  'assets/notification.png', // Replace with actual image path
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 10),
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/profile.png"),
                  radius: 24,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
