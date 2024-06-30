import 'package:flutter/material.dart';

class EmptyGroupsScreen extends StatelessWidget {
  const EmptyGroupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Groups', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenSize.height * 0.01), // Adjust this value as needed
            Image.asset(
              'assets/empty.png', // Replace with the correct path to your image
              height: screenSize.height * 0.35,
            ),
            SizedBox(height: screenSize.height * 0.01),
            const Text(
              "You haven't joined any groups yet",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenSize.height * 0.02),
            const Text(
              "Your subscribed groups will appear here once you create or join a subscription group",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the button press to create or join a group
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}