import 'package:flutter/material.dart';

class SubscriptionCard extends StatelessWidget {
  final String service;
  final String price;
  final String members;
  final String nextpayment;
  final String createdby;
  final bool isRecomended;

  const SubscriptionCard({
    super.key,
    required this.service,
    required this.price,
    required this.members,
    required this.nextpayment,
    required this.createdby,
    this.isRecomended = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 163,
      height: 187,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
        ),
        border: Border.all(width: 1, color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 13),
            decoration: BoxDecoration(
              color: Colors.lightBlue[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/profile.png', // Replace with actual image URL or asset
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Created by : $createdby',
                  style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  "assets/profile.png",
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  service,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RichText(
              text: TextSpan(
                text: price,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                children: const [
                  TextSpan(
                    text: ' / month',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/profile.png', // Replace with the actual path to the members image
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  members,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          const Spacer(), // Add a Spacer to push the button to the bottom
          if (isRecomended)
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(left: 13, bottom: 8), // Adjusted margin to avoid overflow
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                width: 138,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: const Center(
                  child: Text(
                    'Join Group',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          if (!isRecomended)
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 13),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0XFFD1D4D7))),
              ),
              child: Text(
                'Next payment: $nextpayment',
                style: const TextStyle(fontSize: 8, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}
