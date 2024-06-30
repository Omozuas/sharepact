import 'package:flutter/material.dart';

// Dummy screens for navigation
class BrowseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse'),
      ),
      body: const Center(
        child: Text('Browse Screen Content'),
      ),
    );
  }
}